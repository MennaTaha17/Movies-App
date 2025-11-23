// import 'package:dio/dio.dart';
//
// class MoviesService {
//   final Dio _dio = Dio();
//
//   Future<Response> listMovies({
//     String? genre,
//     int limit = 20,
//     String sortBy = "date_added",
//   }) async {
//     return await _dio.get(
//       "https://yts.lt/api/v2/list_movies.json",
//       queryParameters: {
//         "genre": genre,
//         "limit": limit,
//         "sort_by": sortBy,
//         "order_by": "desc",
//       },
//     );
//   }
// }