part of 'quote_bloc.dart';

abstract class QuoteEvent extends Equatable {
  const QuoteEvent();
}

class FetchQuote extends QuoteEvent {
  const FetchQuote();

  @override
  List<Object> get props => [];
}
