class Hall {
  final String? hallid;
  final String nameHall;
  final int row;
  final int column;
  final String? status;

  Hall({
    this.hallid,
    required this.nameHall,
    required this.row,
    required this.column,
    this.status,
  });

  factory Hall.fromJson(Map<String, dynamic> json) {
    return Hall(
      hallid: json['id'].toString(),
      nameHall: json['namehall'] ?? 'unknown',
      row: json['row'] ?? 0,
      column: json['column'] ?? 0,
      status: json['status'] ?? 'closed',
    );
  }
}
