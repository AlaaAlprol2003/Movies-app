abstract class AuthApiConstant{
  static const String moviesApiBase = "https://yts.lt/api/v2/";
  static const String moviesListEndPoint = "list_movies.json";
  static const String movieDetailsEndPoint= "movie_details.json";
  static const String moviesSuggestionsEndPoint="movie_suggestions.json";
  static const String baseUrl = "https://route-movie-apis.vercel.app";
  static const String registerEndPoint = "/auth/register";
  static const String loginEndPoint = "/auth/login";

}
abstract class MoviesApiConstant{
  static const String baseUrl = "https://yts.lt/api/v2/";
  static const String moviesListEndPoint = "list_movies.json";
  static const String movieDetailsEndPoint= "movie_details.json";
  static const String moviesSuggestionsEndPoint="movie_suggestions.json";
}
abstract class AuthLocalConstant {
  static const String tokenKey = "token";
}
abstract class ProfileApiConstant {
  static const String baseUrl ='https://route-movie-apis.vercel.app/';
  static const String getProfileEndPoint ='profile';
  static const String addToWatchListEndPoint ='favorites/add';
}
