import 'dart:async';

import 'package:AniQuotes/models/models.dart';
import 'package:AniQuotes/repositories/quote_api_client.dart';
import 'package:AniQuotes/repositories/repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:http/http.dart' as http;

part 'quote_event.dart';
part 'quote_state.dart';

class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  QuoteBloc() : super(QuoteEmpty());

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async* {
    final QuoteRepository repository =
        QuoteRepository(quoteApiClient: QuoteAPIClient(client: http.Client()));

    if (event is FetchQuote) {
      yield QuoteLoading();
      //* Once we yield QuoteLoading(), wait for our quote to load from the repository before yielding QuoteLoaded()
      //* Otherwise, yield QuoteError()
      try {
        final Quote quote = await repository.fetchQuote();
        yield QuoteLoaded(quote: quote);
      } catch (error) {
        print(error);
        yield QuoteError();
      }
    }
  }
}
