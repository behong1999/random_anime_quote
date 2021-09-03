import 'dart:convert';

import 'package:AniQuotes/models/models.dart';
import 'package:http/http.dart' as http;

class QuoteAPIClient {
  final http.Client client;

  QuoteAPIClient({
    required this.client,
  });

  Future<Quote> fetchQuote() async {
    final url = 'https://animechan.vercel.app/api/random';

    //* Convert an URL string into something the get() method can use
    final response = await this.client.get(Uri.parse(url));

    if (response.statusCode != 200) {
      print(response.statusCode);
      throw new Exception('Error of getting quote');
    }

    //* Parses the string and returns the resulting Json object.
    return Quote.fromJson(jsonDecode(response.body));
  }
}
