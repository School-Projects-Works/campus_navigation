import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/custom_button.dart';
import '../../core/custom_dialog.dart';
import '../../core/custom_input.dart';
import '../../features/contacts/provider/contact_provider.dart';
import '../../utils/colors.dart';
import '../../utils/styles.dart';

class DashboardContactPage extends ConsumerStatefulWidget {
  const DashboardContactPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardContactPageState();
}

class _DashboardContactPageState extends ConsumerState<DashboardContactPage> {
  @override
  Widget build(BuildContext context) {
    var contacts = ref.watch(contactsProvider).filter;
    var styles = Styles(context);
    var titleStyles = styles.title(color: Colors.white, fontSize: 15);
    var rowStyles = styles.body(fontSize: 13);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          if (ref.watch(isNewContact))
            const SizedBox(height: 10)
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Locations',
                  style: styles.title(color: primaryColor),
                ),
                const Spacer(),
                SizedBox(
                  width: 500,
                  child: CustomTextFields(
                    hintText: 'Search for a contact',
                    onChanged: (query) {},
                    suffixIcon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  text: 'Add Contact',
                  onPressed: () {
                    ref.read(isNewContact.notifier).state = true;
                  },
                ),
              ],
            ),
          if (ref.watch(isNewContact)) _buildContactForm(),
          const SizedBox(height: 10),
          Expanded(
            child: DataTable2(
              columnSpacing: 30,
              horizontalMargin: 12,
              empty: Center(
                  child: Text(
                'No Contact found',
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
                  label: Text('Name'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Phone'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Email'.toUpperCase()),
                ),
                DataColumn2(
                  label: Text('Action'.toUpperCase()),
                ),
              ],
              rows: List<DataRow>.generate(contacts.length, (index) {
                var contact = contacts[index];
                return DataRow(
                  cells: [
                    DataCell(Text('${index + 1}', style: rowStyles)),
                    DataCell(Text(contact.name, style: rowStyles)),
                    DataCell(Text(contact.phoneNumber, style: rowStyles)),
                    DataCell(Text(contact.email, style: rowStyles)),
                    DataCell(
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          CustomDialog.showInfo(
                              message:
                                  'Are you sure you want to delete this contact?',
                              buttonText: 'Delete',
                              onPressed: () {
                                ref
                                    .read(contactsProvider.notifier)
                                    .delete(contact.id);
                              });
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

  Widget _buildContactForm() {
    var notifier = ref.watch(newContactProvider.notifier);
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
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: CustomTextFields(
                      hintText: 'Contact Name',
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
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFields(
                      hintText: 'Phone Number',
                      isPhoneInput: true,
                      isDigitOnly: true,
                      validator: (phone) {
                        if (phone == null || phone.isEmpty) {
                          return 'Phone number is required';
                        }
                        return null;
                      },
                      onSaved: (phone) => {
                        notifier.setPhoneNumber(phone!),
                      },
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomTextFields(
                      label: 'Email Address',
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                      onSaved: (email) => {
                        notifier.setEmail(email!),
                      },
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    child: CustomButton(
                      text: 'Save Location',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          notifier.saveContact(ref);
                          _formKey.currentState!.reset();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              ref.read(isNewContact.notifier).state = false;
            },
          )
        ],
      ),
    );
  }
}

final isNewContact = StateProvider<bool>((ref) => false);
