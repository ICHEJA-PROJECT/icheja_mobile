class ResourceDetailEntity<T> {
  final String id;
  final String title;
  final List<T> content;

  ResourceDetailEntity({
    required this.id,
    required this.title,
    required this.content,
  });
}
