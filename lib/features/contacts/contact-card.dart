import 'package:campus_navigation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/finctions.dart';

class ContactCard extends StatefulWidget {
  final String phone, email, title;

  const ContactCard(
      {super.key,
      required this.phone,
      required this.email,
      required this.title});

  @override
  _ContactCardState createState() => _ContactCardState();
}

class _ContactCardState extends State<ContactCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: GoogleFonts.amiko(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
            ),
            const Divider(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.mobile,
                    color: Colors.black45,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.phone,
                    style: GoogleFonts.amiko(
                      fontWeight: FontWeight.w700,
                      color: Colors.black45,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (widget.phone.isNotEmpty) {
                        launchURL(
                          "tel:${widget.phone}",
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: primaryColor, shape: BoxShape.circle),
                      child: const Icon(
                        FontAwesomeIcons.phone,
                        size: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.at,
                    color: Colors.black45,
                    size: 20,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    widget.email,
                    style: GoogleFonts.amiko(
                      fontWeight: FontWeight.w700,
                      color: Colors.black45,
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (widget.email.isNotEmpty) {
                        launchURL(
                          "mailto:${widget.email}",
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                          color: primaryColor, shape: BoxShape.circle),
                      child: const Icon(
                        FontAwesomeIcons.envelope,
                        size: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
