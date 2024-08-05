import 'package:campus_navigation/core/custom_button.dart';
import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/home/provider/locations_provider.dart';
import '../../utils/styles.dart';

class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LocationsPageState();
}

class _LocationsPageState extends ConsumerState<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    var locations = ref.watch(locationProvider).filter;
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    return Container(
      padding: const EdgeInsets.all(15),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Locations',
                style: styles.title(color: primaryColor),
              ),
              const Spacer(),
              CustomTextFields(
                hintText: 'Search for a location',
                prefixIcon: Icons.search,
                onChanged: (p0) => {
                  ref.read(locationProvider.notifier).filter(p0),
                },
              ),
              const SizedBox(
                width: 15,
              ),
              CustomButton(
                text: 'Add Location',
                onPressed: () {
                  ref.read(isNewLocation.notifier).state = true;
                },
              ),
            ],
          ),
          if(ref.watch(isNewLocation))_buildNewLocationForm(),
          const SizedBox(
            height: 15,
          ),
           Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Location found',
                style: rowStyles,
              )),
              minWidth: 600,
              headingRowColor: WidgetStateColor.resolveWith(
                  (states) => primaryColor.withOpacity(0.6)),
              headingTextStyle: titleStyles,
              columns: [
                 DataColumn2(
                    label: Text(
                      'INDEX',
                      style: titleStyles,
                    ),
                    fixedWidth: styles.largerThanMobile ? 80 : null),
                DataColumn2(
                    label: Text('Image'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 80),
               
                DataColumn2(
                  label: Text('Name'.toUpperCase()),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text('Latitude'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 100
                ),
                DataColumn2(
                    label: Text('Longitude'.toUpperCase()),
                    size: ColumnSize.S,
                    fixedWidth: styles.isMobile ? null : 100),
               DataColumn2(
                  label: Text('Action'.toUpperCase()),
                  size: ColumnSize.S,
                  fixedWidth: styles.isMobile ? null : 150,
                ),
              ],
              rows: List<DataRow>.generate(locations.length, (index) {
                var location = locations[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: location.image .isNotEmpty
                                ? DecorationImage(
                                    image: NetworkImage(location.image),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          
                        ),
                      ),
                    ),
                   
                    DataCell(Text(location.name, style: rowStyles)),
                    DataCell(Text(location.lat.toStringAsFixed(3), style: rowStyles)),
                    DataCell(Text(location.lng.toStringAsFixed(3), style: rowStyles)),
                   DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        ref.read(locationProvider.notifier).delete(location);
                      },
                    ),
                   )
                   ],
                );
              }),
            ),
          )
       
        ],
      ),
    );
  }
  
  Widget _buildNewLocationForm() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          CustomTextFields(
            hintText: 'Location Name',
            onChanged: (p0) => {},
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextFields(
            hintText: 'Location Description',
            maxLines: 3,
            onChanged: (p0) => {},
          ),
          const SizedBox(
            height: 15,
          ),
          CustomButton(
            text: 'Save Location',
            onPressed: () {
              ref.read(isNewLocation.notifier).state = false;
            },
          ),
        ],
      ),
    );
  }
}

final isNewLocation = StateProvider<bool>((ref) => false);
