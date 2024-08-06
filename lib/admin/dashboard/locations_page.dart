import 'package:campus_navigation/core/custom_button.dart';
import 'package:campus_navigation/core/custom_dialog.dart';
import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
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
          if (ref.watch(isNewLocation))
            const SizedBox(height: 15)
          else
            Row(
              children: [
                Text(
                  'Locations',
                  style: styles.title(color: primaryColor),
                ),
                const Spacer(),
                SizedBox(
                  width: 500,
                  child: CustomTextFields(
                    hintText: 'Search for a location',
                    prefixIcon: Icons.search,
                    onChanged: (p0) => {
                      ref.read(locationProvider.notifier).filter(p0),
                    },
                  ),
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
          if (ref.watch(isNewLocation)) _buildNewLocationForm(),
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
                    ),
                DataColumn2(
                  label: Text('Name'.toUpperCase()),
                  
                ),
                DataColumn2(
                  label: Text('Description'.toUpperCase()),
                ),
                DataColumn2(
                    label: Text('Latitude'.toUpperCase()),
                    ),
                DataColumn2(
                    label: Text('Longitude'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                 
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
                            
                          ),
                          child: ImageNetwork(
                            image: location.image,
                           width: 50,
                           height: 50,
                          ))
                      ),
                    ),
                    DataCell(Text(location.name, style: rowStyles)),
                     DataCell(Text(location.description??'', style: rowStyles)),
                    DataCell(Text(location.lat.toStringAsFixed(3),
                        style: rowStyles)),
                    DataCell(Text(location.lng.toStringAsFixed(3),
                        style: rowStyles)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
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

  final _formKey = GlobalKey<FormState>();
  Widget _buildNewLocationForm() {
    var notifier = ref.watch(newLocationProvider.notifier);
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: Wrap(
                spacing: 10,
                runSpacing: 22,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        CustomTextFields(
                          hintText: 'Location Name',
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return 'Name is required';
                            }
                            return null;
                          },
                          onSaved: (p0) => {
                            notifier.setName(p0!),
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: CustomTextFields(
                              label: 'Latitude',
                              isDigitOnly: true,
                              keyboardType: TextInputType.number,
                              validator: (lat) {
                                if (lat == null || lat.isEmpty) {
                                  return 'Latitude is required';
                                }
                                return null;
                              },
                              onSaved: (p0) => {
                                notifier.setLat(double.parse(p0!)),
                              },
                            )),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: CustomTextFields(
                              label: 'Longitude',
                              isDigitOnly: true,
                              keyboardType: TextInputType.number,
                              validator: (lng) {
                                if (lng == null || lng.isEmpty) {
                                  return 'Longitude is required';
                                }
                                return null;
                              },
                              onSaved: (p0) => {
                                notifier.setLng(double.parse(p0!)),
                              },
                            )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFields(
                      hintText: 'Location Description',
                      maxLines: 3,
                      onSaved: (p0) => {
                        notifier.setDescription(p0!),
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        const Text('Select at most 3 images of the location'),
                        TextButton.icon(
                            onPressed: () {
                              _pickImages();
                            },
                            label: const Text('Add Image'),
                            icon: const Icon(Icons.image)),
                        const SizedBox(
                          height: 10,
                        ),
                        if (ref.watch(locationImageProvider)!=null)
                         Container(
                                      width: 100,
                                      height: 100,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border:
                                              Border.all(color: Colors.black),
                                          image: DecorationImage(
                                              image: MemoryImage(
                                        ref.watch(locationImageProvider)!),
                                              fit: BoxFit.cover)),
                                      //delete button
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: () {
                                            ref
                                                .read(locationImageProvider
                                                    .notifier)
                                                .removeImage();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(.5),
                                                shape: BoxShape.circle),
                                            child: const Icon(
                                              Icons.cancel,
                                              color: Colors.white,
                                              size: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                               
                          
                        const SizedBox(
                          height: 15,
                        ),
                        CustomButton(
                          text: 'Save Location',
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              if (ref.watch(locationImageProvider)==null) {
                                CustomDialog.showToast(
                                    message: 'At least 1 image is required');
                                return;
                              } else {
                                notifier.save(ref);
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(isNewLocation.notifier).state = false;
            },
          )
        ],
      ),
    );
  }

  void _pickImages() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      var images = await image.readAsBytes();
      ref.read(locationImageProvider.notifier).addImage(images);
    }
  }
}

final isNewLocation = StateProvider<bool>((ref) => false);
