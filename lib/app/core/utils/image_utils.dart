import 'package:photofilters/filters/color_filters.dart';
import 'package:photofilters/filters/subfilters.dart';

class BrightNessEdit extends ColorFilter {
  BrightNessEdit(num brightness) : super(name: "Brightness") {
    subFilters.add(BrightnessSubFilter(brightness));
  }
}

class ContrastEdit extends ColorFilter {
  ContrastEdit(num contrast) : super(name: "Contrast") {
    subFilters.add(ContrastSubFilter(contrast));
  }
}

class ColorEdit extends ColorFilter{
  ColorEdit(int red, int green,int blue) : super(name: "Color"){
    subFilters.add(AddictiveColorSubFilter(red, green, blue));
  }
}

class StaturationEdit extends ColorFilter{
  StaturationEdit(num saturation) : super(name: "Staturation"){
    subFilters.add(SaturationSubFilter(saturation));
  }
}


class SepiaEdit extends ColorFilter{
  SepiaEdit(num sepia) : super(name: "Sepia"){
    subFilters.add(SepiaSubFilter(sepia));
  }
}

class GreyScaleEdit extends ColorFilter{
  GreyScaleEdit() : super(name: "Grey Scale"){
    subFilters.add(GrayScaleSubFilter());
  }
}

class InvertEdit extends ColorFilter{
  InvertEdit():  super(name: "Invert"){
    subFilters.add(InvertSubFilter());
  }
}


class TemplateFilterEdit extends ColorFilter{
  TemplateFilterEdit(num brightness, num contrast, num staturation, int red, int green,int blue) : super(name: "Template"){
    subFilters.add(BrightnessSubFilter(brightness));
    subFilters.add(ContrastSubFilter(contrast));
    subFilters.add(SaturationSubFilter(staturation));
    subFilters.add(AddictiveColorSubFilter(red, green, blue));
  }
}