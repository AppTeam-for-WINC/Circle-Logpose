class Range {
  const Range(this.start, this.endInclusive);

  final double start;
  final double endInclusive;

  double get range => endInclusive - start;

  @override
  String toString() {
    return '[$start; $endInclusive]';
  }
}
