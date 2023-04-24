import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new_respo/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new_respo/model/hot_and_new_respo.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;

  HomeBloc(this._homeService) : super(HomeState.initial()) {
    /* 
    
    
    
    
    on event get homescreen data */

    on<GetHomeScreenData>((event, emit) async {
      //send loading to ui

      emit(state.copyWith(isLoading: true, hasError: false));

      //get Data
      final _movieresult = await _homeService.getHotAndNewMovieData();
      final _tvresult = await _homeService.getHotAndNewTvData();

      //transform data

      final _state1 = _movieresult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo respo) {
          final pastYear = respo.results;
          final trending = respo.results;
          final dramas = respo.results;
          final southIndian = respo.results;
          pastYear.shuffle();
          trending.shuffle();
          dramas.shuffle();
          southIndian.shuffle();
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastYear,
            trendingMovieList: trending,
            tenseDramasMovieList: dramas,
            southIndianMovieList: southIndian,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(_state1);

      final _state2 = _tvresult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramasMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo respo) {
          final top10List = respo.results;

          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramasMovieList: state.tenseDramasMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10List,
            isLoading: false,
            hasError: false,
          );
        },
      );
      //send to ui
      emit(_state2);
    });
  }
}
