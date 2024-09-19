extension StringExtension on String {
  String capitalize() {
    return "{this.substring(1).toLowerCase()}";
  }
}

renameTitle(text) {
  var texted = text.replaceAll('-', ' ');
  return texted[0].toUpperCase() + texted.substring(1).toLowerCase();
}
