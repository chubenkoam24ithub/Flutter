class FakeUser {
  final String name;
  final String city;
  final String avatarPath;
  final List<PostWithMovie> posts;

  FakeUser({
    required this.name,
    required this.city,
    required this.avatarPath,
    required this.posts,
  });
}

class PostWithMovie {
  final String review;
  final MovieShortData movie;

  PostWithMovie({
    required this.review,
    required this.movie,
  });
}

class MovieShortData {
  final String title;
  final String year;
  final String rating;

  MovieShortData({
    required this.title,
    required this.year,
    required this.rating,
  });
}