import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/contacts/contact-card.dart';
import 'package:campus_navigation/features/contacts/data/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView (
        child: Column(
          children: [
            const CustomTextFields(
              hintText: 'Search for a contact',
              suffixIcon: Icon(Icons.search),
            ),
            const SizedBox(height: 10),
            for (var contact in ContactModel.dummyContacts())
              ContactCard(
                  phone: contact.phoneNumber,
                  email: contact.email,
                  title: contact.name)
          ],
        ),
      ),
    );
  }
}
