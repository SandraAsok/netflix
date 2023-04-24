import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: ((context, int newIndex, _) {
          return BottomNavigationBar(
            backgroundColor: Colors.black,
            currentIndex: newIndex,
            onTap: (index) {
              indexChangeNotifier.value = index;
            },
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: white,
            unselectedItemColor: grey,
            selectedIconTheme: const IconThemeData(color: white),
            unselectedIconTheme: const IconThemeData(color: grey),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.collections,
                ),
                label: "New & Hot",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.emoji_emotions,
                ),
                label: "Fast Laughs",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                ),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.download,
                ),
                label: "Downloads",
              ),
            ],
          );
        }));
  }
}
