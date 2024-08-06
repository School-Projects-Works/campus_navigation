import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/contacts/contact-card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/styles.dart';
import 'provider/contact_provider.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  @override
  Widget build(BuildContext context) {
    var contacts = ref.watch(contactsProvider).filter;
    var contactStream = ref.watch(contactsStreamProvider);
    var styles = Styles(context);
    return contactStream.when(
        data: (data) {
          return Container(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: styles.width * .9,
                        child: CustomTextFields(
                          hintText: 'Search for a contact',
                          onChanged: (query) {
                            ref.read(contactsProvider.notifier).filter(query);
                          },
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  for (var contact in contacts)
                    ContactCard(
                        phone: contact.phoneNumber,
                        email: contact.email,
                        title: contact.name)
                ],
              ),
            ),
          );
        },
        loading: () => Container(
            alignment: Alignment.center,
            child: const Center(child: CircularProgressIndicator())),
        error: (error, stack) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error: $error'),
          );
        });
  }
}
