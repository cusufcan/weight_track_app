class UserWeight {
  UserWeight({required this.date, required this.weight});
  final DateTime date;
  double weight;

  @override
  String toString() {
    return '{$date, $weight}';
  }
}
