import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new_respo/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new_respo/model/hot_and_new_respo.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    /*
   get hot and new movie data
    */

    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to ui
      emit(
        const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false,
        ),
      );

//get data from remote
      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo respo) {
          return HotAndNewState(
            comingSoonList: respo.results,
            everyOneIsWatchingList: state.everyOneIsWatchingList,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });

    /*
   get hot and new movie data
    */

    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //send loading to ui
      emit(
        const HotAndNewState(
          comingSoonList: [],
          everyOneIsWatchingList: [],
          isLoading: true,
          hasError: false,
        ),
      );

//get data from remote
      final _result = await _hotAndNewService.getHotAndNewTvData();

      //data to state
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyOneIsWatchingList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewRespo respo) {
          return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyOneIsWatchingList: respo.results,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(newState);
    });
  }
}
