import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/features/movie/data/datasources/movie_datasource_impl.dart';
import 'package:movies_app/features/movie/domain/repositories/movie_repository.dart';

import 'package:movies_app/shared/constanst.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: baseUrl));
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieDatasourceImpl();
});
