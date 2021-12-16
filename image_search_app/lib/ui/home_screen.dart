import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_search_app/model/photo.dart';
import 'package:image_search_app/ui/widget/photo_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photo> _photos = [];
  final _controller = TextEditingController();

  Future<List<Photo>> fetch(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://pixabay.com/api/?key=24829672-e86462931ca2f2cf80fb27137&q=$query&image_type=photo&pretty=true',
      ),
    );

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable hits = jsonResponse['hits'];

    return hits.map((e) => Photo.fromJson(e)).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Image Searcher',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () async {
                    final photos = await fetch(_controller.text);
                    setState(() {
                      _photos = photos;
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _photos.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final photo = _photos[index];
                return PhotoWidget(photo: photo);
              },
            ),
          ),
        ],
      ),
    );
  }
}
