import 'package:campus_navigation/utils/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/custom_input.dart';
import '../../features/emergency/provider/emergency_provider.dart';
import '../../utils/styles.dart';

class EmergenciesPage extends ConsumerStatefulWidget {
  const EmergenciesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EmergenciesPageState();
}

class _EmergenciesPageState extends ConsumerState<EmergenciesPage> {
  @override
  Widget build(BuildContext context) {
    var emergencies = ref.watch(emergencyProvider).filter;

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
                      'INDEX NUMBER',
                      style: titleStyles,
                    ),
                    fixedWidth: styles.largerThanMobile ? 100 : null),
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
                    fixedWidth: styles.isMobile ? null : 100),
                DataColumn2(
                    label: Text('gennder'.toString()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 80),
                DataColumn2(
                  label: Text('Status'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 100,
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
              ],
              rows: List<DataRow>.generate(emergencies.length, (index) {
                var emergency = emergencies[index];
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
                    DataCell(Text(emergency.indexNumber, style: rowStyles)),
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
                          // view the emergency
                        } else {
                          // respond to the emergency
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
}
