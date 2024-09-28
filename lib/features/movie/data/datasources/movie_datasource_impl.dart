import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movies_app/di/di_container.dart';
import 'package:movies_app/features/movie/data/mappers/movie_mappers.dart';
import 'package:movies_app/features/movie/data/models/movies_model.dart';
import 'package:movies_app/features/movie/domain/datasources/movie_datasource.dart';
import 'package:movies_app/features/movie/domain/entities/movie.dart';
import 'package:movies_app/shared/constanst.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MovieDatasourceImpl implements MovieDatasource {
  final Dio dio = ProviderContainer().read(dioProvider);

  @override
  Future<List<Movie>> getMovies() async {
    try {
      final response = await dio.get('/3/movie/now_playing', queryParameters: {
        'api_key': apiKey,
        'page': 1,
      });

      if (response.statusCode == 200) {
        MoviesResponse moviesResponse = MoviesResponse.fromJson(response.data);
        return MovieMapper.toEntities(moviesResponse);
      }

      throw Exception(
          'Invalid response format: Expected a list but got something else');
    } on DioException catch (exception, stackTrace) {
      final int? statusCode = exception.response?.statusCode;
      final String? responseMessage = exception.response?.statusMessage;

      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope.setTag('error_type', 'DioException');
          scope.setTag('http_status_code', statusCode.toString());
          scope.setContexts('HTTP Response', {
            'status_code': statusCode,
            'response_message': responseMessage,
            'request_url': exception.requestOptions.uri.toString(),
          });
          scope.setTag('movie_data', 'error while fetching movies');
        },
      );

      throw Exception(
        'Failed to load movies. HTTP status code: $statusCode. Message: $responseMessage',
      );
    } catch (exception, stackTrace) {
      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
        withScope: (scope) {
          scope.setTag('error_type', exception.runtimeType.toString());
          scope.setContexts('Error Details', {
            'error_type': exception.runtimeType.toString(),
            'message': exception.toString(),
          });
          scope.setTag('movie_data', 'unexpected error while fetching movies');
        },
      );

      throw Exception(
        'An unexpected error occurred while fetching movies: ${exception.runtimeType}',
      );
    }
  }
}
