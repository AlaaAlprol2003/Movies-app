class IsAddedToWatchList {
  const IsAddedToWatchList({
    required this.message,
    required this.isAdded,
  });

  factory IsAddedToWatchList.fromJson(Map<String, dynamic> json) {
    return IsAddedToWatchList(
      message: json['message'] ?? '',
      isAdded: json['data'] ?? false,
    );
  }

  final String message;
  final bool isAdded;
}
