import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:photo_parser/ui/photo_view.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future fetchPhotos() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043');
    print(json.decode(response.body));

    if (response.statusCode == 200)
      return json.decode(response.body);
    else
      throw Exception('Ошибка при загрузке..');
  }

  initState() {
    super.initState();
    // photosList = _photosRepo.fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photos Parser'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
          future: fetchPhotos(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData)
              return ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 25),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: <Widget>[
                      InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => PhotoView(
                              image: snapshot.data[index]['urls']['small'],
                            ),
                          ),
                        ),
                        child: Image.network(
                          '${snapshot.data[index]['urls']['small']}',
                          width: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      SizedBox(width: 30),
                      Flexible(
                        child: Column(
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                      text:
                                          'Описание\n${snapshot.data[index]['description']}\n\n'),
                                  TextSpan(
                                      text:
                                          'Автор: \n${snapshot.data[index]['user']['username']}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            else if (snapshot.hasError) return Text('${snapshot.error}');

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
