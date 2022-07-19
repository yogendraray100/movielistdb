import 'package:dio/dio.dart';
import 'package:project1/src/model/movie.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = 'https:/api.themoviedb.org/3';
  final String apiKey = 'api_key=YOUR-API-KEY';

  Future<List<Movie>> getNowPlayingMovie() async {
    try {
      final url = '$baseUrl/movie/_now_playing?$apiKey';
      print('api call: $url');
      final response = await _dio.get(url);
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error, stacktrace) {
      print('error');
      throw Exception(
          'Exception accoured: $error with stacktrace: $stacktrace');
    }
  }
}
