// import 'package:flushbar/flushbar.dart'
import 'package:flutter/material.dart';
import 'package:random_quote/database.dart';
import 'package:random_quote/models/models.dart';

class FavoriteQuotes extends StatefulWidget {
  const FavoriteQuotes({Key? key}) : super(key: key);

  @override
  _FavoriteQuotesState createState() => _FavoriteQuotesState();
}

class _FavoriteQuotesState extends State<FavoriteQuotes> {
  var db = MyDatabase();
  late Future<List<Quote>> quotes;

  void initState() {
    super.initState();
    quotes = db.fetchSavedQuotes();
  }

  Widget Refresh() {
    return Positioned(
      bottom: 50,
      right: 5,
      child: Tooltip(
        message: 'Press to Refresh The List',
        child: FloatingActionButton(
            backgroundColor: Colors.pink.shade300,
            onPressed: () {
              print('refresh');
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.thumb_up),
                      Text(
                        ' REFRESHED ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Icon(Icons.thumb_up),
                    ],
                  ),
                  backgroundColor: Colors.deepPurple));
              setState(() {
                quotes = db.fetchSavedQuotes();
              });
            },
            child: Icon(
              Icons.refresh,
              color: Colors.white,
              size: 50,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Quote>>(
        future: quotes,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.length > 0) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (builder, index) {
                          return Card(
                              shape: RoundedRectangleBorder(
                                  side: BorderSide(color: Colors.purple),
                                  borderRadius: BorderRadius.circular(10)),
                              shadowColor: Colors.blue.shade100,
                              color: Colors.white10,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(6.0),
                                    child: Text(
                                      '${snapshot.data![index].anime}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.toDouble(),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Text(
                                            '${snapshot.data![index].quote}',
                                            style: TextStyle(fontSize: 18.0),
                                          )),
                                      IconButton(
                                          alignment: Alignment.centerRight,
                                          icon: Icon(Icons.delete),
                                          color: Colors.red,
                                          onPressed: () {
                                            setState(() {
                                              db.deleteQuoteFromFavorite(
                                                  '${snapshot.data![index].quote}');

                                              quotes = db.fetchSavedQuotes();
                                            });

                                            final removedSnackBar = SnackBar(
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  'Removed From Favorites',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                backgroundColor:
                                                    Colors.deepPurple);
                                            ScaffoldMessenger.of(context)
                                              ..removeCurrentSnackBar()
                                              ..showSnackBar(removedSnackBar);
                                          }),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 10.0, top: 10),
                                    child: Text(
                                      '- ${snapshot.data![index].character} -',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ));
                        }),
                  ),
                  Refresh(),
                ],
              );
            } else {
              return Stack(children: [
                Center(
                  child: Text(
                    'No Data in the Favorites',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'quoteScript'),
                  ),
                ),
                Refresh()
              ]);
            }
          } else if (snapshot.hasError) {
            return Stack(
              children: [
                Center(
                  child: Text('Failed to Load Favorites'),
                ),
                Refresh()
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
