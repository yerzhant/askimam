class ImamRating {
  final String name;
  final int rating;

  const ImamRating(this.name, this.rating);

  factory ImamRating.fromJson(Map<String, dynamic> json) =>
      ImamRating(json['name'], json['rating']);
}
