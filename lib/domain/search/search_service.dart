import 'package:dartz/dartz.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/search/model/search_respo/search_respo.dart';

abstract class SearchService {
  Future<Either<MainFailure, SearchRespo>> searchMovies({
    required String movieQuery,
  });
}
