import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new_respo/model/hot_and_new_respo.dart';

abstract class HotAndNewService {
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewMovieData();
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewTvData();
}
