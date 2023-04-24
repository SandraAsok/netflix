import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index, required this.imageUrl});
  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(children: [
          const SizedBox(
            width: 40,
            height: 150,
          ),
          Container(
            width: 140,
            height: 250,
            decoration: BoxDecoration(
              borderRadius: kradius10,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(imageUrl),
              ),
            ),
          ),
        ]),
        Positioned(
          left: 15,
          bottom: 10,
          child: BorderedText(
            strokeWidth: 5.0,
            strokeColor: white,
            child: Text(
              "${index + 1}",
              style: TextStyle(
                color: black,
                fontSize: 120,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
