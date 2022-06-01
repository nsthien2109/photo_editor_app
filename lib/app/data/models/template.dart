class TemplateModel {
  String? id;
  String? nameTemplate;
  double? brightness;
  double? contrast;
  double? saturation;
  int? red;
  int? green;
  int? blue;
  String? author;
  String? userId;
  bool? isApproved;

  TemplateModel(
      {this.id,
      this.nameTemplate,
      this.brightness,
      this.contrast,
      this.saturation,
      this.red,
      this.green,
      this.blue,
      this.author,
      this.userId,
      this.isApproved});

  TemplateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTemplate = json['name-template'];
    brightness = json['brightness'];
    contrast = json['contrast'];
    saturation = json['saturation'];
    red = json['red'];
    green = json['green'];
    blue = json['blue'];
    author = json['author'];
    userId = json['userId'];
    isApproved = json['isApproved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name-template'] = nameTemplate;
    data['brightness'] = brightness;
    data['contrast'] = contrast;
    data['saturation'] = saturation;
    data['red'] = red;
    data['green'] = green;
    data['blue'] = blue;
    data['author'] = author;
    data['userId'] = userId;
    data['isApproved'] = isApproved;
    return data;
  }
}