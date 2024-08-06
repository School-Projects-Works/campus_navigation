import 'dart:typed_data';
import 'package:campus_navigation/core/custom_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import '../data/emergency_model.dart';
import '../services/emergency_services.dart';

final emergencyStreamProvider =
    StreamProvider.autoDispose<List<EmergencyModel>>((ref) async* {
  var data = EmergencyServices.getEmergencies();
  await for (var event in data) {
    ref.read(emergencyProvider.notifier).setList(event);
    yield event;
  }
});

class EmergencyFilter {
  List<EmergencyModel> list;
  List<EmergencyModel> filter;
  EmergencyFilter({
    required this.list,
    required this.filter,
  });

  EmergencyFilter copyWith({
    List<EmergencyModel>? list,
    List<EmergencyModel>? filter,
  }) {
    return EmergencyFilter(
      list: list ?? this.list,
      filter: filter ?? this.filter,
    );
  }
}

final emergencyProvider =
    StateNotifierProvider<EmergencyProvider, EmergencyFilter>((ref) {
  return EmergencyProvider();
});

class EmergencyProvider extends StateNotifier<EmergencyFilter> {
  EmergencyProvider() : super(EmergencyFilter(list: [], filter: []));

  void setList(List<EmergencyModel> list) {
    state = state.copyWith(list: list, filter: list);
  }

  void filter(String query) {
    if (query.isEmpty) {
      state = state.copyWith(filter: state.list);
    } else {
      state = state.copyWith(
          filter: state.list
              .where((element) =>
                  element.name.toLowerCase().contains(query.toLowerCase()))
              .toList());
    }
  }

  void ignore(EmergencyModel emergency) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Ignoring Emergency..');
    var result = await EmergencyServices.updateEmergency(emergency.id, {
      'status': 'ignored',
    });
    CustomDialog.dismiss();
    if (result) {
      CustomDialog.showSuccess(message: 'Emergency ignored successfully');
    } else {
      CustomDialog.showError(message: 'Failed to ignore emergency');
    }
  }

  void respond(EmergencyModel emergency) async{
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Responding to Emergency..');
    var result = await EmergencyServices.updateEmergency(emergency.id, {
      'status': 'responded',
    });
    CustomDialog.dismiss();
    if (result) {
      CustomDialog.showSuccess(message: 'Emergency responded successfully');
    } else {
      CustomDialog.showError(message: 'Failed to respond to emergency');
    }
  }
}

final newEmergennyProvider =
    StateNotifierProvider<NewEmergency, EmergencyModel>((ref) {
  return NewEmergency();
});

class NewEmergency extends StateNotifier<EmergencyModel> {
  NewEmergency() : super(EmergencyModel.defualt());

  void setName(String s) {
    state = state.copyWith(name: s);
  }

  void setPhone(String s) {
    state = state.copyWith(phoneNumber: s);
  }

  void setGender(String string) {
    state = state.copyWith(gender: string);
  }

  void setTitle(String s) {
    state = state.copyWith(title: s);
  }

  void setDescription(String s) {
    state = state.copyWith(description: s);
  }

  void setLocation(LocationData locationData) {
    state =
        state.copyWith(lat: locationData.latitude, lng: locationData.longitude);
  }

  void addEmergency(WidgetRef ref) async {
    CustomDialog.showLoading(message: 'Sunbmitting Emergency..');
    var image = ref.watch(emergencyImageProvider);
    if (image != null) {
      var url = await EmergencyServices.uploadImage(image);
      if (url.isNotEmpty) {
        state = state.copyWith(image: url);
        ref.read(emergencyImageProvider.notifier).state = null;
      }
    }
    if (state.lat == 0.0 || state.lng == 0.0) {
      var location = await Location().getLocation();
      state = state.copyWith(lat: location.latitude, lng: location.longitude);
    }
    state = state.copyWith(
      id: EmergencyServices.getNewId(),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      status: 'pending',
    );
    var result = await EmergencyServices.addEmergency(state);
    CustomDialog.dismiss();
    if (result) {
      CustomDialog.showSuccess(message: 'Emergency submitted successfully');
    } else {
      CustomDialog.showError(message: 'Failed to submit emergency');
    }
  }
}

final emergencyImageProvider = StateProvider<Uint8List?>((ref) => null);
