import 'package:assignment2/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

/// First tab: listing of places with search bar and cards.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black,
      child: SizedBox.expand(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CustomSearchBar(),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                children: const [
                  CustomCard(
                    title: 'Toronto, Canada',
                    cost: 200,
                    distance: 257,
                    availableDates: 'Oct 24 - 26',
                    imageUrl: 'assets/image1.jpeg',
                  ),
                  CustomCard(
                    title: 'Toronto, Canada',
                    cost: 200,
                    distance: 257,
                    availableDates: 'Oct 24 - 26',
                    imageUrl: 'assets/image2.jpg',
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
