import 'package:campus_navigation/core/custom_button.dart';
import 'package:campus_navigation/core/custom_drop_down.dart';
import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/emergency/provider/emergency_provider.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:campus_navigation/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class EmergencyPage extends ConsumerStatefulWidget {
  const EmergencyPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends ConsumerState<EmergencyPage> {
  final _formKey = GlobalKey<FormState>();

void getLocation()async{
    Location location =  Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    //check if widget is done building
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newEmergennyProvider.notifier).setLocation(_locationData);
    });
}
@override
  void initState() {
    getLocation();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var style = Styles(context);
    var notifier = ref.read(newEmergennyProvider.notifier);
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Report an emergency',
                    style: style.title(color: primaryColor, fontSize: 20)),
                Text(
                  'Please note that your location will be shared with the emergency services',
                  style: style.body(color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                CustomTextFields(
                  label: 'Name',
                  hintText: 'Enter your name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (name) {
                    notifier.setName(name!);
                  },
                ),
                const SizedBox(height: 22),
                CustomTextFields(
                  label: 'Phone number',
                  hintText: 'Enter your phone number',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (phone) {
                    notifier.setPhone(phone!);
                  },
                ),
                const SizedBox(height: 22),
                //gender
                CustomDropDown(
                    label: 'Gender',
                    hintText: 'Select your',
                    validator: (gender) {
                      if (gender == null) {
                        return 'Please select your gender';
                      }
                      return null;
                    },
                    onChanged: (gender) {
                      notifier.setGender(gender.toString());
                    },
                    items: ['Male', 'Female']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList()),
               
               
                const SizedBox(height: 22),
                //title and description
                CustomTextFields(
                  label: 'Title',
                  hintText: 'Enter the title',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  onSaved: (title) {
                    notifier.setTitle(title!);
                  },
                ),
                const SizedBox(height: 22),
                CustomTextFields(
                  label: 'Description',
                  maxLines: 3,
                  hintText: 'Enter the description',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the description';
                    }
                    return null;
                  },
                  onSaved: (description) {
                    notifier.setDescription(description!);
                  },
                ),
                const SizedBox(height: 22),
                //pick image
                TextButton(onPressed: (){
                 //show source snackbar
                 showModalBottomSheet(
                   context: context,
                   builder: (context) => Column(
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       ListTile(
                         leading: const Icon(Icons.camera),
                         title: const Text('Camera'),
                         onTap: (){
                          _pickImage('camera');
                         },
                       ),
                       ListTile(
                         leading: const Icon(Icons.image),
                         title: const Text('Gallery'),
                         onTap: (){
                          _pickImage('gallery');
                         },
                       ),
                     ],
                   ),
                 );
                  
                  
                }, child: const Text('Pick Image')),
                if(ref.watch(emergencyImageProvider)!=null)
                 Container(
                                    width: 80,
                                    height: 80,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(color: Colors.black),
                                        image: DecorationImage(
                                            image: MemoryImage(
                                                ref.watch(emergencyImageProvider)!),
                                            fit: BoxFit.cover)),
                                    //delete button
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: InkWell(
                                        onTap: () {
                                          ref.read(emergencyImageProvider.notifier).state=null;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(.5),
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
                             

                const SizedBox(height: 22),
                CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      //save the emergency
                      ref.read(newEmergennyProvider.notifier).addEmergency(ref);
                      _formKey.currentState!.reset();
                    }
                  },
                  text: 'Report',
                ),
              ],
            ),
          ),
        ));
  }
  
  void _pickImage(String source)async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source == 'camera' ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedFile != null) {
      var imageByte = await pickedFile.readAsBytes();
      ref.read(emergencyImageProvider.notifier).state=imageByte;
    }
  }
}
