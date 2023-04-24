import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/api_end_points.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:dartz/dartz.dart';
import 'package:netflix/domain/hot_and_new_respo/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new_respo/model/hot_and_new_respo.dart';

@LazySingleton(as: HotAndNewService)
class HotAndNewImplementation implements HotAndNewService {
  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewMovieData() async {
    try {
      final response =
          await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewMovie);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewRespo.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.ServerFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.ClientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.ClientFailure());
    }
  }

  @override
  Future<Either<MainFailure, HotAndNewRespo>> getHotAndNewTvData() async {
    try {
      final response = await Dio(BaseOptions()).get(ApiEndPoints.hotAndNewTv);
      // log(response.data.toString());
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = HotAndNewRespo.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailure.ServerFailure());
      }
    } on DioError catch (e) {
      log(e.toString());
      return const Left(MainFailure.ClientFailure());
    } catch (e) {
      log(e.toString());
      return const Left(MainFailure.ClientFailure());
    }
  }
}
