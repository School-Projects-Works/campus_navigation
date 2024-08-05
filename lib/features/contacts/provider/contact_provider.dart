import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_navigation/features/contacts/services/contacts_services.dart';

import '../data/contact_model.dart';

final contactsStreamProvider =
    StreamProvider.autoDispose<List<ContactModel>>((ref)async* {
  var data = ContactsServices.getContacts();
  await for (var event in data) {
    ref.read(contactsProvider.notifier).setList(event);
    yield event;
  }
});

class ConatctFilter {
  List<ContactModel>  list;
  List<ContactModel> filter;
  ConatctFilter({
    required this.list,
    required this.filter,
  });
  

  ConatctFilter copyWith({
    List<ContactModel>? list,
    List<ContactModel>? filter,
  }) {
    return ConatctFilter(
      list: list ?? this.list,
      filter: filter ?? this.filter,
    );
  }
}
final contactsProvider = StateNotifierProvider<ContactsProvider, ConatctFilter>((ref) {
  return ContactsProvider();
});


class ContactsProvider extends StateNotifier<ConatctFilter> {
  ContactsProvider() : super(ConatctFilter(list: [], filter: []));

  void setList(List<ContactModel> list) {
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