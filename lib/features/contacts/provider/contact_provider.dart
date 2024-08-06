import 'package:campus_navigation/core/custom_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:campus_navigation/features/contacts/services/contacts_services.dart';

import '../data/contact_model.dart';

final contactsStreamProvider =
    StreamProvider.autoDispose<List<ContactModel>>((ref) async* {
  var data = ContactsServices.getContacts();
  await for (var event in data) {
    ref.read(contactsProvider.notifier).setList(event);
    yield event;
  }
});

class ConatctFilter {
  List<ContactModel> list;
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

final contactsProvider =
    StateNotifierProvider<ContactsProvider, ConatctFilter>((ref) {
  return ContactsProvider();
});

class ContactsProvider extends StateNotifier<ConatctFilter> {
  ContactsProvider() : super(ConatctFilter(list: [], filter: []));

  void setList(List<ContactModel> list) {
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

  void delete(String id) async {
    CustomDialog.dismiss();
    CustomDialog.showLoading(message: 'Deleting contact...');
    var response = await ContactsServices.deleteContact(id);
    if (response) {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Contact deleted successfully');
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Failed to delete contact');
    }
  }
}

final newContactProvider =
    StateNotifierProvider<NewContactProvider, ContactModel>((ref) {
  return NewContactProvider();
});

class NewContactProvider extends StateNotifier<ContactModel> {
  NewContactProvider()
      : super(ContactModel(id: '', name: '', phoneNumber: '', email: ''));

  void setName(String name) {
    state = state.copyWith(name: name);
  }

  void setPhoneNumber(String phoneNumber) {
    state = state.copyWith(phoneNumber: phoneNumber);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void reset() {
    state = ContactModel(id: '', name: '', phoneNumber: '', email: '');
  }

  void saveContact(WidgetRef ref) async {
    CustomDialog.showLoading(message: 'Saving contact...');
    state = state.copyWith(id: ContactsServices.getNewId());
    var response = await ContactsServices.addContact(state);
    if (response) {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Contact saved successfully');
      reset();
    } else {
      CustomDialog.dismiss();
      CustomDialog.showToast(message: 'Failed to save contact');
    }
  }
}
