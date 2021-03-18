import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey[900],
        highlightColor: Colors.grey[700],
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.white70,
            child: Text("cum")
        )
    );
  }
}
