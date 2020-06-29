import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_parser/models/photos-model.dart';

class PhotosRepo {
  Future fetchPhotos() async {
    final response = await http.get(
        'https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');
    print(json.decode(response.body));

    if (response.statusCode == 200)
      return PhotosModel.fromJson(json.decode(response.body));
    else
      throw Exception('Ошибка при загрузке..');
  }
}
