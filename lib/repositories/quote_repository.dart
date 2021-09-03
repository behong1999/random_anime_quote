//? DATA REPOSITORY
//* The point of the file is to create a layer that wraps around our API calls.
//* It only calls the quote_api_client.dart methods,
//* but in real-world usage it allows you to separate calling the API
//* and handling the data you get from it
import 'package:AniQuotes/models/models.dart';
import 'package:AniQuotes/repositories/quote_api_client.dart';

class QuoteRepository {
  final QuoteAPIClient quoteApiClient;

  QuoteRepository({required this.quoteApiClient});

  Future<Quote> fetchQuote() async {
    return await quoteApiClient.fetchQuote();
  }
}
