class MovieData {
  int id;
  String title;
  String description;
  String image;
  String date;
  double rating;

  MovieData(
    this.id,
    this.title,
    this.description,
    this.image,
    this.date,
    this.rating,
  );

  static MovieData fromJson(Map<String, dynamic> json) {
    return MovieData(
      json['id'],
      json['title'] ?? "",
      json['overview'] ?? "",
      json['poster_path'] ?? "",
      json['release_date'] ?? "N/A",
      (json['vote_average'] ?? 0).toDouble(),
    );
  }
}