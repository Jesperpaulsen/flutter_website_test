extension Capitalize on String {
  String capitalize() {
    if (this.isEmpty) return this;
    if (this.length == 1) return this.toUpperCase();
    final firstChar = this[0].toUpperCase();
    return '$firstChar${this.substring(1).toLowerCase()}';
  }
}
