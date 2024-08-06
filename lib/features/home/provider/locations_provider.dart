import 'dart:typed_data';
import 'package:campus_navigation/core/custom_dialog.dart';
import 'package:campus_navigation/features/home/data/place_item.dart';
import 'package:campus_navigation/features/home/services/places_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final locationStreamProvider =
    StreamProvider.autoDispose<List<PlaceItem>>((ref) async* {
  var data = PlacesServices.getPlaces();
  await for (var event in data) {
    ref.read(locationProvider.notifier).setList(event);
    yield event;
  }
});

class LocationFilter {
  List<PlaceItem> list;
  List<PlaceItem> filter;
  LocationFilter({
    required this.list,
    required this.filter,
  });

  LocationFilter copyWith({
    List<PlaceItem>? list,
    List<PlaceItem>? filter,
  }) {
    return LocationFilter(
      list: list ?? this.list,
      filter: filter ?? this.filter,
    );
  }
}

final locationProvider =
    StateNotifierProvider<LocationProvider, LocationFilter>((ref) {
  return LocationProvider();
});

class LocationProvider extends StateNotifier<LocationFilter> {
  LocationProvider() : super(LocationFilter(list: [], filter: []));

  void setList(List<PlaceItem> list) {
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

  void delete(PlaceItem location) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting location');
    var result = await PlacesServices.deletePlace(location.id);
    if (result) {
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: 'Location deleted successfully');
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to delete location');
    }
  }
}

final newLocationProvider =
    StateNotifierProvider<NewLocationProvider, PlaceItem>((ref) {
  return NewLocationProvider();
});

class NewLocationProvider extends StateNotifier<PlaceItem> {
  NewLocationProvider() : super(PlaceItem.defualt());

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setLat(double lat) {
    state = state.copyWith(lat: lat);
  }

  void setLng(double lng) {
    state = state.copyWith(lng: lng);
  }

  void setImage(String image) {
    state = state.copyWith(image: image);
  }

  void setDescription(String description) {
    state = state.copyWith(description: () => description);
  }

  void save(WidgetRef ref) async {
    CustomDialog.showLoading(message: 'Saving location');
    var images = ref.watch(locationImageProvider);
    if (images != null) {
      var url = await PlacesServices.uploadImage(images);
      state = state.copyWith(image: url);
    }
    state = state.copyWith(published: true,
    id: PlacesServices.getPlaceId()
    );
    var result = await PlacesServices.savePlace(state);
    if (result) {
      CustomDialog.dismiss();
      CustomDialog.showSuccess(message: 'Location saved successfully');
    } else {
      CustomDialog.dismiss();
      CustomDialog.showError(message: 'Failed to save location');
    }
  }
}

final locationImageProvider =
    StateNotifierProvider<LocationImage, Uint8List?>((ref) => LocationImage());

class LocationImage extends StateNotifier<Uint8List?> {
  LocationImage() : super(null);

  void addImage(Uint8List data) {
    state = data;
  }

  void removeImage() {
    state = null;
  }
}
