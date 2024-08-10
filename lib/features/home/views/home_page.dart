import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/map/views/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../provider/locations_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    var locationnStream = ref.watch(locationStreamProvider);
    return locationnStream.when(
        data: (data) {
          var locations = ref.watch(locationProvider).filter;
          return SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  spacing: 10,
                  runAlignment: WrapAlignment.center,
                  alignment: WrapAlignment.center,
                  runSpacing: 10,
                  children: [
                     Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CustomTextFields(
                        hintText: 'Search for a place',
                        onChanged: (p0) => {
                          ref.read(locationProvider.notifier).filter(p0),
                        },
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                    for (int i = 0; i < locations.length; i++)
                      InkWell(
                        onTap: () {
                          //navigate to place details
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapRoutingPage(
                                    lat: locations[i].lat,
                                    lng: locations[i].lng,
                                  )));
                        },
                        child: Container(
                            width: 170,
                            height: 200,
                            alignment: Alignment.bottomCenter,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        locations[i].image),
                                    fit: BoxFit.cover)),
                            child: Container(
                                color: Colors.black.withOpacity(0.8),
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  locations[i].name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ))),
                      )
                  ],
                )
              ],
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          return Center(child: Text('Error: $error'));
        });
  }
}
