extension StringExtension on String {
  bool isHttpOrHttps() =>
      trim().startsWith("http") || trim().startsWith("https");
}
