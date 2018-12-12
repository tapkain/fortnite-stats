import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final ValueChanged<String> _onSearchUpdate;

  Search(this._onSearchUpdate);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search),
          hintText: 'Search',
          border: InputBorder.none
        ),
        onSubmitted: (result) {
          _onSearchUpdate(result);
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.black12
      ),
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16)
    );
  }
}