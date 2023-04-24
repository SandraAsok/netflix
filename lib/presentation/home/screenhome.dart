import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/widgets/main_title_card.dart';

ValueNotifier<bool> ScrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: ScrollNotifier,
      builder: (context, value, _) {
        return NotificationListener<UserScrollNotification>(
          onNotification: ((notification) {
            final ScrollDirection direction = notification.direction;
            if (direction == ScrollDirection.reverse) {
              ScrollNotifier.value = false;
            } else if (direction == ScrollDirection.forward) {
              ScrollNotifier.value = true;
            }
            return true;
          }),
          child: Stack(
            children: [
              BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  } else if (state.hasError) {
                    return const Center(
                        child: Text(
                      'Error while getting data',
                      style: TextStyle(color: white),
                    ));
                  }

                  // released past year
                  final _releasesPastYear = state.pastYearMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //trending
                  final _trending = state.trendingMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //tense dramas
                  final _tenseDramas = state.tenseDramasMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //south indian
                  final _southIndian = state.southIndianMovieList.map((m) {
                    return '$imageAppendUrl${m.posterPath}';
                  }).toList();

                  //top 10 tv shows
                  final _top10TvShows = state.trendingTvList.map((t) {
                    return '$imageAppendUrl${t.posterPath}';
                  }).toList();

                  //list view

                  return ListView(
                    children: [
                      BackgroundCard(),
                      MainTitleCard(
                        title: "Released in the past year",
                        posterList: _releasesPastYear.sublist(0, 10),
                      ),
                      kheight,
                      MainTitleCard(
                        title: "Trending Now",
                        posterList: _trending.sublist(0, 10),
                      ),
                      kheight,
                      NumberTitleCard(
                        postersList: _top10TvShows.sublist(0, 10),
                      ),
                      kheight,
                      MainTitleCard(
                        title: "Tense Dramas",
                        posterList: _tenseDramas.sublist(0, 10),
                      ),
                      kheight,
                      MainTitleCard(
                        title: "South Indian Cinema",
                        posterList: _southIndian.sublist(0, 10),
                      ),
                      kheight,
                    ],
                  );
                },
              ),
              ScrollNotifier.value == true
                  ? AnimatedContainer(
                      duration: Duration(microseconds: 1000),
                      width: double.infinity,
                      height: 90,
                      color: Colors.black.withOpacity(0.5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.network(
                                "https://about.netflix.com/images/meta/netflix-symbol-black.png",
                                width: 60,
                                height: 60,
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.cast,
                                size: 30,
                                color: Colors.white,
                              ),
                              kwidth,
                              Container(
                                width: 30,
                                height: 30,
                                color: Colors.blue,
                              ),
                              kwidth,
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("TV Shows", style: kHomeTitleText),
                              Text(
                                "Movies",
                                style: kHomeTitleText,
                              ),
                              Text(
                                "Categories",
                                style: kHomeTitleText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : kheight,
            ],
          ),
        );
      },
    ));
  }
}
