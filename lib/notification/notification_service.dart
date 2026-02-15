import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  final http.Client httpClient;

  NotificationService({required this.httpClient});

  Future<List<String>> fetchNotifications() async {
    final response = await httpClient.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => json['title'] as String).toList();
    } else {
      throw Exception('Failed to load notifications');
    }
  }
}
