import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/BOOK.dart';

class FeaturedEbookCard extends StatelessWidget {
  final Ebook ebook;

  FeaturedEbookCard(this.ebook);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              ebook.coverImage,
              width: 150,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 8),
          Text(
            ebook.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ebook.author,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
