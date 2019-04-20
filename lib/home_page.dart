import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:jokes/jokes.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Jokes jokes;

  Future<void> fetchJokes() async {
    var res =
        await http.get("https://official-joke-api.appspot.com/jokes/random");
    var decRes = jsonDecode(res.body);
    jokes = Jokes.fromJson(decRes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        title: Text("Let\'s Laugh"),
        centerTitle: true,
        elevation: 5,
      ),
      body: RefreshIndicator(
        onRefresh: fetchJokes,
        child: FutureBuilder(
          future: fetchJokes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return Text("Press button to start");
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: RefreshProgressIndicator(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) return errorData(snapshot);
                return displayJokes();
            }
            return null;
          },
        ),
      ),
    );
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error: ${snapshot.error}"),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            onPressed: () {
              fetchJokes();
              setState(() {});
            },
            child: Text("Try Again"),
          ),
        ],
      ),
    );
  }

  Widget displayJokes() {
    return ListView(
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 120,
              ),
              Text(
                jokes.setup,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrangeAccent,
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                jokes.punchline,
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.deepOrangeAccent[400],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              ButtonTheme(
                height: 45,
                minWidth: 60,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: Colors.deepOrangeAccent[700],
                  elevation: 5,
                  onPressed: () {
                    fetchJokes();
                  },
                  child: Text(
                    "Keep Me Laughing",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ],
    );
  }
}
