
// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as image_lib;

class FilterUtils {
  static final Map<String, List<int>> _cacheFilter = {};

  static void clearCache() => _cacheFilter.clear();

  static void saveCachedFilter(Filter filter, List<int> imageBytes) {
    if (filter == null) return;

    _cacheFilter[filter.name] = imageBytes;
  }

  static List<int>? getCachedFilter(Filter filter) {
    if (filter == null) return null;

    return _cacheFilter[filter.name];
  }

  static Future<List<int>> applyFilter(image_lib.Image image, Filter filter) {
    if (filter == null) throw Exception('Filter not set');

    return compute(
      _applyFilterInternal,
      <String, dynamic>{
        'filter': filter,
        'image': image,
        'width': image.width,
        'height': image.height,
      },
    );
  }

  static List<int> _applyFilterInternal(Map<String, dynamic> params) {
    Filter filter = params["filter"];
    image_lib.Image image = params["image"];
    int width = params["width"];
    int height = params["height"];

    final bytes = image.getBytes();
    filter.apply(bytes, width, height);

    final newImage = image_lib.Image.fromBytes(width, height, bytes);
    return image_lib.encodeJpg(newImage);
  }


  
}