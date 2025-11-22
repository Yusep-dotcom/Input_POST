import 'dart:convert';
import 'package:flutter_application_1/model/http_stateful.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class PostFromPage extends StatefulWidget {
  const PostFromPage({super.key});

  @override
  State<PostFromPage> createState() => _PostFromPageState();
}

class _PostFromPageState extends State<PostFromPage> {
  TextEditingController titleControler = TextEditingController();
  TextEditingController bodyControler = TextEditingController();

  String result = '';

  Future<void> connectAPI() async {
    Uri url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

    var bodyData = {
      'title': titleControler.text,
      'body': bodyControler.text,
      'userId': 1,
    };

    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(bodyData),
    );

    PostModel post = PostModel.fromJson(jsonDecode(response.body));

    setState(() {
      result =
          'STATUS: ${response.statusCode}\n\nTitle: ${post.title}\nBody: ${post.body}\nID: ${post.id}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Latihan POST - Input Form')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Title'),
            TextField(
              controller: titleControler,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hint: Text('Masukan title'),
              ),
            ),

            SizedBox(height: 20),

            const Text('Body'),
            TextField(
              controller: bodyControler,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukan bosy',
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(onPressed: connectAPI, child: Text('Submit POST')),

            SizedBox(height: 20),

            const Text('Hasil Response'),

            SizedBox(height: 16),

            Text(result),
          ],
        ),
      ),
    );
  }
}
