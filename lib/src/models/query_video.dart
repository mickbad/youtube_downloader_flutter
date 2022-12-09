class QueryVideo {
  final String title;
  final String id;
  final String author;
  final Duration duration;
  final String thumbnail;
  final DateTime? uploadDate;
  final String? uploadDateRaw;

  const QueryVideo(this.title, this.id, this.author, this.duration, this.thumbnail, this.uploadDate, this.uploadDateRaw);
}
