class SearchResult {

  final bool cancel;
  final bool manual;

  SearchResult({
    required this.cancel, 
    this.manual = false
  });

  //TODO: Name, description, lation

  @override
  String toString() {
    return '{cancel: $cancel, manual: $manual}';
  }


}