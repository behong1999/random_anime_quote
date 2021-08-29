import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:random_quote/bloc/bloc.dart';
import 'package:random_quote/database.dart';
import 'package:random_quote/models/models.dart';
import 'package:share/share.dart';

class Spacer extends StatelessWidget {
  const Spacer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
    );
  }
}

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuoteBloc, QuoteState>(builder: (context, state) {
      if (state is QuoteEmpty) {
        BlocProvider.of<QuoteBloc>(context).add(FetchQuote());
      }

      if (state is QuoteError) {
        return Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
              Image.network(
                  'https://mir-s3-cdn-cf.behance.net/projects/404/ed7253105313541.Y3JvcCwyNTAwLDE5NTUsMCwyNzI.jpg'),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.2),
                child: Text('Failed to fetch quote'),
              ),
            ]));
      }

      if (state is QuoteLoaded) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  state.quote.anime!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.toDouble(),
                  ),
                ),
                Spacer(),
                Card(
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(10)),
                  shadowColor: Colors.blue.shade100,
                  color: Colors.white10,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          state.quote.quote!,
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '- ${state.quote.character} -',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Tooltip(
                      preferBelow: false,
                      message: 'Share To Your Friends',
                      child: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          print('you shared');
                          Share.share(
                              '"${state.quote.quote}"\n-- ${state.quote.character} (${state.quote.anime})');
                        },
                      ),
                    ),
                    Tooltip(
                      message: 'Save To Favorites',
                      preferBelow: false,
                      child: IconButton(
                          icon: Icon(Icons.favorite, color: Colors.red),
                          onPressed: () async {
                            //* Save into the database
                            var database = MyDatabase();
                            Quote q = Quote(
                                anime: state.quote.anime,
                                quote: state.quote.quote,
                                character: state.quote.character);
                            if (await database.check(state.quote.quote) == 0) {
                              database.saveQuote(q);
                              print('you liked');
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.favorite),
                                        Text(' Added To Favorites ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                        Icon(Icons.favorite),
                                      ],
                                    ),
                                    backgroundColor: Colors.deepPurple));
                            } else {
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Text('Added Already!',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                    backgroundColor: Colors.deepPurple));
                            }
                          }),
                    ),
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () =>
                      BlocProvider.of<QuoteBloc>(context).add(FetchQuote()),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white54, offset: Offset(3, -3))
                        ],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF021F4B),
                            Color(0xFF4C3B71),
                            Color(0xFF115268)
                          ],
                        )),
                    child: Text(
                      'Get Another Quote',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return Center(child: Image.network('https://i.gifer.com/cp.gif'));
    });
  }
}
