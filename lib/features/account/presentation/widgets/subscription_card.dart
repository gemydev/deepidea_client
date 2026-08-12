import 'package:flutter/material.dart';

import '../../../../injection_container/injection_container.dart';
import '../../../cart/presentation/cubit/cart/cart_cubit.dart';
import '../../../home/data/models/responses/get_services_list_of_packages_with_fav_response.dart';

class SubscriptionCard extends StatelessWidget {
  final String title;
  final String price;
  final String packageDetails;
  final String duration;
  final List<String> features;
  final Package package;

  const SubscriptionCard({
    super.key,
    required this.title,
    required this.price,
    required this.packageDetails,
    required this.duration,
    required this.features,
    required this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      // Fixed width for horizontal scrolling
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        // Fix for overflow issue
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min, // Prevent unnecessary expansion
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: '$price ',
                    style: const TextStyle(color: Colors.black87),
                  ),
                  TextSpan(
                    text: 'رس / $duration',
                    style: const TextStyle(color: Colors.orange),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            Text(
              packageDetails,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                sl<CartCubit>().addPackage(package);
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white),
              label: const Text(
                'أضف إلى السلة',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: features
                  .map((feature) => _buildFeature(feature))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.blueAccent, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionList extends StatelessWidget {
  const SubscriptionList({super.key, required this.packages});

  final List<Package> packages;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> subscriptions = packages.map((package) {
      return {
        'title': package.packageName!,
        'price': package.priceDetails!.cost.toString(),
        'duration': '',
        'packageDetails': package.packageDetails,
        'features': package.subFeatures!
            .map((element) => element.features)
            .toList(),
      };
    }).toList();

    return SizedBox(
      height: 320, // Adjust height to fit content properly
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: subscriptions.length,
        itemBuilder: (context, index) {
          var sub = subscriptions[index];
          return SubscriptionCard(
            package: packages[index],
            title: sub['title'],
            price: sub['price'],
            packageDetails: sub["packageDetails"],
            duration: sub['duration'],
            features: List<String>.from(sub['features']),
          );
        },
      ),
    );
  }
}
