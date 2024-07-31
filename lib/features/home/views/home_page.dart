import 'package:campus_navigation/core/custom_input.dart';
import 'package:campus_navigation/features/home/data/place_item.dart';
import 'package:campus_navigation/features/map/views/map_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 10,
          runAlignment: WrapAlignment.center,
          alignment: WrapAlignment.center,
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: CustomTextFields(
                hintText: 'Search for a place',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            for (int i = 0; i < PlaceItem.dummyData().length; i++)
              InkWell(
                onTap: (){
                  //navigate to place details
                   Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => MapRoutingPage(
                        lat: PlaceItem.dummyData()[i].lat,
                        lng: PlaceItem.dummyData()[i].lng,
                      )));
                },
                child: Container(
                    width: 170,
                    height: 200,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(PlaceItem.dummyData()[i].image),
                            fit: BoxFit.cover)),
                    child: Container(
                        color: Colors.black.withOpacity(0.8),
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          PlaceItem.dummyData()[i].name,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ))),
              )
          ],
        )
      ],
    );
  }
}
