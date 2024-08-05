import 'package:riverpod/riverpod.dart';
import '../data/emergency_model.dart';
import '../services/emergency_services.dart';
final emergencyStreamProvider =
    StreamProvider.autoDispose<List<EmergencyModel>>((ref)async* {
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


final emergencyProvider = StateNotifierProvider<EmergencyProvider, EmergencyFilter>((ref) {
  return EmergencyProvider();
});


class EmergencyProvider extends StateNotifier<EmergencyFilter> {
  EmergencyProvider() : super(EmergencyFilter(list: [], filter: []));

  void setList(List<EmergencyModel> list) {
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
}