
extension FORMAT on String {
  String toPNG() {
    return 'assets/images/png/$this.png';
  }

  String toSVG() {
    return 'assets/images/$this.svg';
  }

  String toJPG() {
    return 'assets/images/$this.jpg';
  }
}
