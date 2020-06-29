class PhotosModel {
  final String small;

  PhotosModel({this.small});

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
      small: json['urls']['small'],
    );
  }
}
