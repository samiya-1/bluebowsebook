import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/BOOK.dart';

class MyLibraryEbookCard extends StatelessWidget {
  final Ebook ebook;

  MyLibraryEbookCard(this.ebook);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(ebook.coverImage),
      ),
      title: Text(ebook.title),
      subtitle: Text(ebook.author),
      onTap: () {
        // Implement eBook opening logic
      },
    );
  }
}
