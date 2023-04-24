import 'package:flutter/material.dart';
import 'package:netflix/presentation/downloads/screendownloads.dart';
import 'package:netflix/presentation/fastlaugh/screen_fastlaugh.dart';
import 'package:netflix/presentation/home/screenhome.dart';
import 'package:netflix/presentation/mainpage/widgets/bottomnav.dart';
import 'package:netflix/presentation/new_and_hot/screen_newandhot.dart';
import 'package:netflix/presentation/search/screen_search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({super.key});

  final _pages = [
    ScreenHome(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearch(),
    ScreenDownloads(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: indexChangeNotifier,
          builder: ((context, int index, _) {
            return _pages[index];
          }),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
