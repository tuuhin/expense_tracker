String? showErrorsList(Map<String, dynamic>? err) {
  if (err == null) {
    return null;
  }

  List<String> errors = [...err.values.map((e) => e.toString())];

  return errors.join("\n");
}
