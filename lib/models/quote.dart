import 'package:equatable/equatable.dart';

//* Create the fields
class Quote extends Equatable {
  String? anime;
  String? quote;
  String? character;

  Quote({this.anime, this.quote, this.character});

  //* Allow equatable to do its thing and allow us to compare two diffrent quotes
  @override
  List<Object?> get props => [anime, quote, character];

  static Quote fromJson(dynamic json) {
    return Quote(
      anime: json['anime'],
      quote: json['quote'],
      character: json['character'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote_anime': anime,
      'quote_text': quote,
      'quote_character': character,
    };
  }

  Quote.fromMap(Map<String, dynamic> map) {
    anime = map['quote_anime'];
    quote = map['quote_text'];
    character = map['quote_character'];
  }

  //* It will be printed after a transition from one state to another thanks to 'props'
  @override
  String toString() => 'Quote { anime: $anime, character: $character }';
}
