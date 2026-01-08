import 'dart:convert';

PeliculasModel peliculasModelFromJson(String str) =>
    PeliculasModel.fromJson(json.decode(str));

String peliculasModelToJson(PeliculasModel data) => json.encode(data.toJson());

class PeliculasModel {
  dynamic adult;
  dynamic backdropPath;
  List<dynamic> genreIds;
  dynamic id;
  dynamic originalLanguage;
  dynamic originalTitle;
  dynamic overview;
  dynamic popularity;
  dynamic posterPath;
  dynamic releaseDate;
  dynamic title;
  dynamic video;
  dynamic voteAverage;
  dynamic voteCount;

  PeliculasModel({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory PeliculasModel.fromJson(Map<String, dynamic> json) => PeliculasModel(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    genreIds: json["genre_ids"] ?? [],
    id: json["id"],
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"],
    posterPath: json["poster_path"],
    releaseDate: json["release_date"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
    "id": id,
    "original_language": originalLanguage,
    "original_title": originalTitle,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "release_date": releaseDate,
    "title": title,
    "video": video,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
