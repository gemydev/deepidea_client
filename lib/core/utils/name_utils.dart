class NameUtils {
  static Map<String, String> splitName(String? fullName) {
    if (fullName == null || fullName.trim().isEmpty) {
      return {"firstName": "غير متوفر", "lastName": "غير متوفر"};
    }

    final parts = fullName.trim().split(" ");
    final firstName = parts.isNotEmpty ? parts.first : "غير متوفر";
    final lastName =
        parts.length > 1 ? parts.sublist(1).join(" ") : "غير متوفر";

    return {"firstName": firstName, "lastName": lastName};
  }
}
