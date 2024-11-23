class Group {
  String title;
  String description;
  List<String> tags;
  List<String> memberIds;

  Group({
    required this.title,
    required this.description,
    this.tags = const [],
    this.memberIds = const [],
  });
}
