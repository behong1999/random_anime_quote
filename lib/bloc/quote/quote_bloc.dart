import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:random_quote/models/models.dart';
import 'package:random_quote/repositories/quote_repository.dart';
import 'package:random_quote/repositories/quote_api_client.dart';
import 'package:random_quote/repositories/repository.dart';
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
