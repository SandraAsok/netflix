import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget({
    Key? key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kheight,
          Text(
            movieName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          kheight,
          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 16,
              color: grey,
            ),
          ),
          kheight50,
          VideoWidget(
            url: posterPath,
          ),
          kheight,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [
              CustomButtonWidget(
                icon: Icons.send,
                title: "Share",
                iconSize: 25,
                textSize: 16,
              ),
              kwidth,
              CustomButtonWidget(
                icon: Icons.add,
                title: "My List",
                iconSize: 25,
                textSize: 16,
              ),
              kwidth,
              CustomButtonWidget(
                icon: Icons.play_arrow,
                title: "Play",
                iconSize: 25,
                textSize: 16,
              ),
              kwidth,
            ],
          ),
        ],
      ),
    );
  }
}
