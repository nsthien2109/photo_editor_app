import 'package:photofilters/filters/image_filters.dart';
import 'package:photofilters/filters/subfilters.dart';
import 'package:photo_editor_pro/app/core/utils/effect_custom.dart';

var effectCustom = [
  ImageFilter(name: "Identity")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(IDENTITY)),
  ImageFilter(name: "Gaussian I")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(GAUSSIAN3X3)),
  ImageFilter(name: "Blur")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(BLUR)),
  ImageFilter(name: "Gaussian II")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(GAUSSIAN5X5)),
  ImageFilter(name: "Sharpen")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(SHARPEN_LOW)),
  ImageFilter(name: "Emboss")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(EMBOSS)),
  ImageFilter(name: "Median I")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(MEDIAN3x3)),
  ImageFilter(name: "Median II")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(MEDIAN5x5)),
  ImageFilter(name: "Laplace")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(LAPLACE)),
  ImageFilter(name: "High Pass")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(HIGHPASS)),
  ImageFilter(name: "Sobel Horizontal")
    ..addSubFilter(ConvolutionSubFilter.fromKernel(SOBEL_H_3X3)),
];
