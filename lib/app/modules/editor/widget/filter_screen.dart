// ignore_for_file: use_key_in_widget_constructors

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_editor_pro/app/core/utils/filter_utils.dart';
import 'package:photo_editor_pro/app/widgets/loading.dart';
import 'package:photofilters/filters/filters.dart';
import 'package:image/image.dart' as image_lib;

class FilteredImageWidget extends StatefulWidget {
  Filter filter;
  image_lib.Image image;
  final Widget Function(Uint8List imageBytes) successBuilder;
  final Widget Function() errorBuilder;

  FilteredImageWidget({
    required this.image,
    required this.filter,
    required this.successBuilder,
    required this.errorBuilder,
  });

  @override
  State<FilteredImageWidget> createState() => _FilteredImageWidgetState();
}

class _FilteredImageWidgetState extends State<FilteredImageWidget>{


  @override
  Widget build(BuildContext context) {
    final cachedImageBytes = 
    FilterUtils.getCachedFilter(widget.filter);
    if (cachedImageBytes == null) {
      return buildFilterFuture(context);
    } else {
      return buildFilter(cachedImageBytes);
    }
  }
  

  Widget buildFilterFuture(context) {
    return FutureBuilder<List<int>>(
      future: FilterUtils.applyFilter(widget.image, widget.filter),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(
                child: Container(
                  width: 45,
                  height: 45,
                  color: Colors.white.withOpacity(.5),
                  child: const Loading()
                ),
            );
          default:
            if (snapshot.hasError) {
              return buildError();
            } else {
              //FilterUtils.saveCachedFilter(Provider.of<HomeProvider>(context, listen: false).filter, snapshot.data!);
              return buildFilter(snapshot.data!);
            }
        }
      },
    );
  }

  Widget buildFilter(List<int> imageBytes) => widget.successBuilder(Uint8List.fromList(imageBytes));

  Widget buildError() => widget.errorBuilder();
}