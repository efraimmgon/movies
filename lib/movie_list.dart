import 'package:flutter/material.dart';
import 'http_helper.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  String result = "";
  late HttpHelper helper;

  @override
  void initState() {
    helper = HttpHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    helper.getUpcoming().then((value) {
      setState(() {
        result = value!;
      });
    });
    return Scaffold(
      appBar: AppBar(title: Text('Movies')),
      body: Container(
        child: Text(result),
      ),
    );
  }
}
