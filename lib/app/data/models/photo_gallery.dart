class PhotoGallery {
  int? id;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? src;

  PhotoGallery(
      {this.id,
      this.url,
      this.photographer,
      this.photographerUrl,
      this.photographerId,
      this.src});

  PhotoGallery.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    src = json['src'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['src'] = src;
    return data;
  }
}