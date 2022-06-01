
import 'package:photofilters/utils/convolution_kernels.dart';

ConvolutionKernel IDENTITY = ConvolutionKernel([
  0, 0, 0,
  0, 1, 0,
  0, 0, 0
]);
ConvolutionKernel SHARPEN = ConvolutionKernel([
  -1, -1, -1,
  -1, 9, -1,
  -1, -1, -1
]);
ConvolutionKernel SHARPEN_LOW = ConvolutionKernel([
  -1, -1, -1,
  -1, 9, -1,
  -1, -1, -1
]);
ConvolutionKernel LAPLACE = ConvolutionKernel([
  0, 1, 0,
  1, -4, 1,
  0, 1, 0
]);
ConvolutionKernel HIGHPASS = ConvolutionKernel([
  -1, -1, -1,
  -1, 8, -1,
  -1, -1, -1
]);

ConvolutionKernel LAPLACIAN5x5 = ConvolutionKernel([
  -1, -1, -1,-1, -1,
  -1, -1, -1, -1, -1,
  -1, -1, 25, -1, -1,
  -1, -1, -1, -1, -1,
  -1, -1, -1, -1, -1
]);
ConvolutionKernel SOBEL_H_3X3 = ConvolutionKernel([
  1, 2, 1,
  0, 0, 0,
  -1, -2, -1
]);
ConvolutionKernel SOBEL_V_3X3 = ConvolutionKernel([
  -1, 0, 1,
  -2, 0, 2,
  -1, 0, 1
]);



ConvolutionKernel GAUSSIAN3X3 = ConvolutionKernel([
  1, 2, 1,
  2, 4, 2,
  1, 2, 1,
]);

ConvolutionKernel GAUSSIAN5X5 = ConvolutionKernel([
  2, 04, 05, 04, 2,
  4, 09, 12, 09, 4,
  5, 12, 15, 12, 5,
  4, 09, 12, 09, 4,
  2, 04, 05, 04, 2
]);

ConvolutionKernel GAUSSIAN7X7 =  ConvolutionKernel([
  1, 1, 2, 2, 2, 1, 1,
  1, 2, 2, 4, 2, 2, 1,
  2, 2, 4, 8, 4, 2, 2,
  2, 4, 8, 16, 8, 4, 2,
  2, 2, 4, 8, 4, 2, 2,
  1, 2, 2, 4, 2, 2, 1,
  1, 1, 2, 2, 2, 1, 1,
]);

ConvolutionKernel MEDIAN3x3 =  ConvolutionKernel([
  1, 1, 1,
  1, 1, 1,
  1, 1, 1,
]);

ConvolutionKernel MEDIAN5x5 =  ConvolutionKernel([
  1, 1, 1, 1, 1,
  1, 1, 1, 1, 1,
  1, 1, 1, 1, 1,
  1, 1, 1, 1, 1,
  1, 1, 1, 1, 1
]);


ConvolutionKernel V_PREWITT  = ConvolutionKernel([
  1, 1, 1,
  0, 0, 0,
  -1, -1, -1
]);
ConvolutionKernel BLUR = ConvolutionKernel([
  0, 0, 1, 0, 0,
  0, 1, 1, 1, 0,
  1, 1, 1, 1, 1,
  0, 1, 1, 1, 0,
  0, 0, 1, 0, 0
]);
ConvolutionKernel EMBOSS = ConvolutionKernel([
  -1, -1, 0,
  -1, 0, 1,
   0, 1, 1
], bias: 128);
