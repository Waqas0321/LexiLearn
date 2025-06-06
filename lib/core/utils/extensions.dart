extension ImagePathExtensions on String {
  /// Converts the string to a PNG image path.
  String get toPng => 'assets/images/$this.png';
  String get fruitToPng => 'assets/fruits/$this.png';
  String get animalToPng => 'assets/animals/$this.png';
  String get alphabetsToPng => 'assets/alphabets/$this.png';
  String get alphabetsThingsToPng => 'assets/alphabets/things/$this.png';
  String get bodyPartsToPng => 'assets/bodyparts/$this.png';
  String get countingToPng => 'assets/numbers/$this.png';
  String get countingThingsToPng => 'assets/numbers/things/$this.png';

  /// Converts the string to a JPG image path.
  String get toJpg => 'assets/images/$this.jpg';

  /// Converts the string to a JPEG image path.
  String get toJpeg => 'assets/images/$this.jpeg';

  /// Converts the string to a GIF image path.
  String get toGif => 'assets/images/$this.gif';

}
