import 'package:campus_navigation/admin/dashboard/components/dasboard_item.dart';
import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/contacts/provider/contact_provider.dart';
import 'package:campus_navigation/features/emergency/data/emergency_model.dart';
import 'package:campus_navigation/features/emergency/provider/emergency_provider.dart';
import 'package:campus_navigation/features/home/provider/locations_provider.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:campus_navigation/utils/styles.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../core/custom_dialog.dart';

class DashboardHome extends ConsumerStatefulWidget {
  const DashboardHome({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<DashboardHome> {
  @override
  Widget build(BuildContext context) {
    var locations = ref.watch(locationProvider).list;
    var contacts = ref.watch(contactsProvider).list;
    var emergencies = ref.watch(emergencyProvider).list;
    var pendingEmergencies = ref
        .watch(emergencyProvider)
        .filter
        .where((element) => element.status == 'pending')
        .toList();
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Wrap(
            spacing: 12,
            runAlignment: WrapAlignment.center,
            runSpacing: 12,
            children: [
              DashBoardItem(
                  icon: Icons.location_city,
                  title: 'Locations',
                  itemCount: locations.length,
                  color: Colors.blue,
                  onTap: () {}),
              DashBoardItem(
                  icon: Icons.contact_emergency,
                  title: 'Contacts',
                  itemCount: contacts.length,
                  color: Colors.green,
                  onTap: () {}),
              DashBoardItem(
                  icon: Icons.warning,
                  title: 'Emergencies',
                  itemCount: emergencies.length,
                  color: Colors.orange,
                  onTap: () {}),
            ],
          ),
          Text(
            'Resent Reports',
            style: styles.title(color: primaryColor),
          ),
          const SizedBox(
            height: 15,
          ),
          SizedBox(
            width: 500,
            child: CustomTextFields(
              hintText: 'Search for a report',
              prefixIcon: Icons.search,
              onChanged: (p0) => {
                ref.read(emergencyProvider.notifier).filter(p0),
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Report found',
                style: rowStyles,
              )),
              minWidth: 600,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => primaryColor.withOpacity(0.6)),
              headingTextStyle: titleStyles,
              columns: [
                DataColumn2(
                    label: Text('Image'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 80),
                DataColumn2(
                  label: Text(
                    'TITLE',
                    style: titleStyles,
                  ),
                ),
                DataColumn2(
                  label: Text('Name'.toUpperCase()),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text('description'.toUpperCase()),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                    label: Text('Phone'.toUpperCase()),
                    size: ColumnSize.M,
                    fixedWidth: styles.isMobile ? null : 150),
                DataColumn2(
                    label: Text('gennder'.toString()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 80),
                DataColumn2(
                  label: Text('Status'.toUpperCase()),
                  size: ColumnSize.M,
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
              ],
              rows: List<DataRow>.generate(pendingEmergencies.length, (index) {
                var emergency = pendingEmergencies[index];
                return DataRow(
                  cells: [
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: emergency.image != null
                                ? DecorationImage(
                                    image: NetworkImage(emergency.image!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: emergency.image == null
                              ? const Icon(Icons.person)
                              : null,
                        ),
                      ),
                    ),
                    DataCell(Text(emergency.title, style: rowStyles)),
                    DataCell(Text(emergency.name, style: rowStyles)),
                    DataCell(Text(emergency.description, style: rowStyles)),
                    DataCell(Text(emergency.phoneNumber, style: rowStyles)),
                    DataCell(Text(emergency.gender, style: rowStyles)),
                    DataCell(Container(
                        width: 90,
                        // alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                            color: emergency.status == 'Responded'
                                ? Colors.green
                                : emergency.status == 'pending'
                                    ? Colors.grey
                                    : Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(emergency.status,
                            style: rowStyles.copyWith(color: Colors.white)))),
                    DataCell(PopupMenuButton(
                      onSelected: (value) {
                        if (value == 'view') {
                          //open a small dialog to view the emergency
                          vewReport(emergency);
                        } else if (value == 'ignore') {
                          CustomDialog.showInfo(
                              message:
                                  'Are you sure you want to ignore this emergency?',
                              onPressed: () {
                                ref
                                    .read(emergencyProvider.notifier)
                                    .ignore(emergency);
                              },
                              buttonText: 'Ignore');

                          // respond to the emergency
                        } else if (value == 'respond') {
                          CustomDialog.showInfo(
                              message:
                                  'Are you sure you want to respond to this emergency?',
                              onPressed: () {
                                ref
                                    .read(emergencyProvider.notifier)
                                    .respond(emergency);
                              },
                              buttonText: 'Respond');
                        }
                      },
                      icon: const Icon(Icons.apps),
                      itemBuilder: (context) {
                        return [
                          const PopupMenuItem(
                            value: 'view',
                            child: Text('View'),
                          ),
                          if (emergency.status != 'Responded')
                            const PopupMenuItem(
                              value: 'respond',
                              child: Text('Respond'),
                            ),
                          if (emergency.status == 'pending')
                            const PopupMenuItem(
                              value: 'ignore',
                              child: Text('Ignore'),
                            ),
                        ];
                      },
                    )),
                  ],
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  void vewReport(EmergencyModel emergency) async {
    var styles = Styles(context);
    // List<Placemark> placemarks =
    //     await placemarkFromCoordinates(emergency.lat, emergency.lng);
    // var place = placemarks.first;
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: const Text('Emergency Details'),
            content: Container(
              width: 500,
              height: 600,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Details',
                        style: styles.title(color: primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: secondaryColor,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name:',
                            style: styles.body(),
                          ),
                          Text(
                            emergency.name,
                            style: styles.subtitle(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //gender
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Gender:', style: styles.body()),
                          Text(emergency.gender, style: styles.subtitle()),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone:',
                            style: styles.body(),
                          ),
                          Text(
                            emergency.phoneNumber,
                            style: styles.subtitle(),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: secondaryColor,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Emergency Details',
                        style: styles.title(color: primaryColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Title:',
                            style: styles.body(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              emergency.title,
                              style: styles.subtitle(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description:',
                            style: styles.body(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              emergency.description,
                              style: styles.subtitle(),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: secondaryColor,
                        thickness: 2,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //image
                      if (emergency.image != null)
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: emergency.image != null
                                ? DecorationImage(
                                    image: NetworkImage(emergency.image!),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                        ),

                      TextButton(
                          onPressed: () {
                            MapsLauncher.launchCoordinates(
                                emergency.lat, emergency.lng);
                          },
                          child: Text(
                            'View on map',
                            style: styles.subtitle(color: primaryColor),
                          )),

                      //image
                    ]),
              ),
            )));
  }
}
