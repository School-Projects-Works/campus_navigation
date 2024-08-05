import 'package:campus_navigation/features/home/data/place_item.dart';
import 'package:campus_navigation/features/home/services/places_services.dart';
import 'package:riverpod/riverpod.dart';

final locationStreamProvider = StreamProvider.autoDispose<List<PlaceItem>>((ref)async* {
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


final locationProvider = StateNotifierProvider<LocationProvider, LocationFilter>((ref) {
  return LocationProvider();
});

class LocationProvider extends StateNotifier<LocationFilter> {
  LocationProvider() : super(LocationFilter(list: [], filter: []));

  void setList(List<PlaceItem> list) {
    state = state.copyWith(list: list,filter: list);
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

  void delete(PlaceItem location) {}
}