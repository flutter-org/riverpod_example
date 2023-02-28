import 'dart:convert';

class Http {
  Future<String> get(String path) async {
    List<Map<String, dynamic>> result = [
      {
        'id': '1',
        'description': 'todo1',
        'completed': false,
      },
      {
        'id': '2',
        'description': 'todo2',
        'completed': false,
      },
      {
        'id': '3',
        'description': 'todo3',
        'completed': true,
      },
    ];
    String json = jsonEncode(result);
    return json;
  }

  Future<void> post(String path, dynamic param) async {}

  Future<void> delete(String path) async {}

  Future<void> patch(String path, dynamic param) async {}
}
