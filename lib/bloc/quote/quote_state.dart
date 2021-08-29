part of 'quote_bloc.dart';

abstract class QuoteState extends Equatable {
  const QuoteState();

  @override
  List<Object> get props => [];
}

//* Haven't got a quote yet
class QuoteEmpty extends QuoteState {}

//* Getting a quote but not having arrived yet
class QuoteLoading extends QuoteState {}

//* Quote has arrived
class QuoteLoaded extends QuoteState {
  final Quote quote;

  const QuoteLoaded({required this.quote});

  //* This will transfer this.quote's toString method to onTransition void
  @override
  List<Object> get props => [this.quote];
}

//* Something wrong happens while trying to get a quote
class QuoteError extends QuoteState {}
