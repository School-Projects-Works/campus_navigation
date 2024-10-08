import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:campus_navigation/features/home/provider/home_page_provider.dart';
import 'package:campus_navigation/features/home/views/home_page.dart';
import 'package:campus_navigation/generated/assets.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../contacts/contact_page.dart';
import '../../emergency/views/emergency_page.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            bottomNavigationBar: BottomNavyBar(
              selectedIndex: ref.watch(selectedPageProvider),
              onItemSelected: (index) {
                ref.read(selectedPageProvider.notifier).state = index;
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    title: const Text('Home'), icon: const Icon(Icons.home)),
                BottomNavyBarItem(
                    title: const Text('Emergency'),
                    icon: const Icon(Icons.local_police)),
                BottomNavyBarItem(
                    title: const Text('Contact'),
                    icon: const Icon(Icons.contact_phone)),
              ],
            ),
            appBar: AppBar(
              elevation: 3,
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  Image.asset(
                    Assets.imagesIconT,
                    height: 40,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Campus Navigator',
                    style: GoogleFonts.laila(color: primaryColor),
                  ),
                ],
              ),
            ),
            body: ref.watch(selectedPageProvider) == 0
                ? const HomePage()
                : ref.watch(selectedPageProvider) == 1
                    ? const EmergencyPage()
                    : const ContactPage()));
  }
}
