
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
class ClientsReview extends StatelessWidget {
  final List<Map<String, dynamic>> reviews;

  const ClientsReview({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: reviews.map((review) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingBarIndicator(
                rating: (review['stars'] ?? 0).toDouble(),
                itemCount: 5,
                itemSize: 20,
                direction: Axis.horizontal,
                itemBuilder: (context, index) =>
                    Icon(Icons.star, color: Colors.blue.shade500),
              ),
              const SizedBox(height: 10),
              Text(
                review['reviewTopic'] ?? '',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: review['reviewerName'] ?? '',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    const TextSpan(
                        text: " • ",
                        style: TextStyle(color: Colors.grey, fontSize: 14)),
                    TextSpan(
                      text: review['reviewDate'] ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
          Text( review['reviewText'] ?? '',
        maxLines: 4, overflow: TextOverflow.ellipsis,),

            ],
          ),
        );
      }).toList(),
    );
  }
}
