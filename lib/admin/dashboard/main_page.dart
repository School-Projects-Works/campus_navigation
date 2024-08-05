import 'package:campus_navigation/features/contacts/provider/contact_provider.dart';
import 'package:campus_navigation/features/emergency/provider/emergency_provider.dart';
import 'package:campus_navigation/features/home/provider/locations_provider.dart';
import 'package:campus_navigation/router/router.dart';
import 'package:campus_navigation/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../generated/assets.dart';
import '../../router/router_items.dart';
import '../../utils/styles.dart';
import 'components/app_bar_item.dart';
import 'components/side_bar.dart';

class DashboardMain extends ConsumerStatefulWidget {
  const DashboardMain({super.key, required this.child});
  final Widget child;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<DashboardMain> {
  @override
  Widget build(BuildContext context) {
    var styles = Styles(context);
    var locationnsStream = ref.watch(locationStreamProvider);
    var emergenciesStream = ref.watch(emergencyStreamProvider);
    var contactsStream = ref.watch(contactsStreamProvider);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: Row(
              children: [
                Image.asset(
                  Assets.imagesLogoT,
                  height: 40,
                ),
                const SizedBox(width: 10),
                if (styles.smallerThanTablet)
                  //manu button

                  buildAdminManu(ref, context)
              ],
            ),
          ),
          body: Container(
            color: Colors.white60,
            padding: const EdgeInsets.all(4),
            child: styles.smallerThanTablet
                ? widget.child
                : Row(
                    children: [
                      const SideBar(),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                              color: Colors.grey[100],
                              padding: const EdgeInsets.all(10),
                              child: locationnsStream.when(
                                loading: () => const Center(
                                    child: CircularProgressIndicator()),
                                error: (error, stack) {
                                  return Center(child: Text(error.toString()));
                                },
                                data: (data) {
                                  return emergenciesStream.when(
                                      data: (user) {
                                        return contactsStream.when(
                                            data: (notice) {
                                              return widget.child;
                                             },
                                            error: (error, stack) {
                                              return Center(
                                                  child:
                                                      Text(error.toString()));
                                            },
                                            loading: () => const Center(
                                                child:
                                                    CircularProgressIndicator()));
                                      },
                                      error: (error, stack) {
                                        return Center(
                                            child: Text(error.toString()));
                                      },
                                      loading: () => const Center(
                                          child: CircularProgressIndicator()));
                                },
                              )))
                    ],
                  ),
          )),
    );
  }

  Widget buildAdminManu(WidgetRef ref, BuildContext context) {
    return PopupMenuButton(
      color: primaryColor,
      offset: const Offset(0, 70),
      child: const Icon(
        Icons.menu,
        color: Colors.white,
      ),
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.dashboard,
                title: 'Dashboard',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.dashboardRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.location_on,
                title: 'Locations',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.locationsRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.warning,
                title: 'Emergency',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.emergenciesRoute);
                  Navigator.of(context).pop();
                }),
          ),
          PopupMenuItem(
            child: BarItem(
                padding: const EdgeInsets.only(
                    right: 40, top: 10, bottom: 10, left: 10),
                icon: Icons.contact_phone,
                title: 'Contacts',
                onTap: () {
                  MyRouter(context: context, ref: ref)
                      .navigateToRoute(RouterItem.contactsRoute);
                  Navigator.of(context).pop();
                }),
          ),
         ];
      },
    );
  }
}

