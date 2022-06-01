// ignore_for_file: prefer_final_fields, deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as image_lib;
import 'package:page_transition/page_transition.dart';
import 'package:pexels_null_safety/pexels_null_safety.dart';
import 'package:photo_editor_pro/app/core/utils/image_utils.dart';
import 'package:photo_editor_pro/app/data/models/photo_gallery.dart';
import 'package:photo_editor_pro/app/data/models/template.dart';
import 'package:photo_editor_pro/app/modules/editor/editor_screen.dart';
import 'package:photo_editor_pro/app/modules/editor/widget/test.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/apply_template.dart';
import 'package:photo_editor_pro/app/modules/templates/widgets/create_template.dart';
import 'package:photofilters/photofilters.dart';

class HomeProvider extends ChangeNotifier{

  final _carouselController = CarouselController();
  CarouselController get carouselController => _carouselController;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;
  List<PhotoGallery> _photos = [];
  List<PhotoGallery> get photos => _photos;

  File? _imageFile;
  File get imageFile => _imageFile!;

  Uint8List? _bytesImage;
  Uint8List get bytesImage => _bytesImage!;

  String? _filename;
  String get filename => _filename!;

  image_lib.Image? _image;
  image_lib.Image get image => _image!;

  Filter _filter = NoFilter();
  Filter get filter => _filter;

  Filter _effect = presetConvolutionFiltersList[0];
  Filter get effect => _effect;

  late Timer timer;

  var client = PexelsClient('563492ad6f91700001000001c915a09f91864da1a60c7080afc7a83b');


// state bytes image to create template
  File? _imageFileTerm;
  File get imageFileTerm => _imageFileTerm!;

  Uint8List? _bytesImageTerm;
  Uint8List get bytesImageTerm => _bytesImageTerm!;

  image_lib.Image? _imageTerm;
  image_lib.Image get imageTerm => _imageTerm!;
  
  Filter _filterTerm = NoFilter();
  Filter get filterTerm => _filter;


  int _currentFilter = 3;
  int get currentFilter => _currentFilter;

  // state để xét độ cao của bottom khi cần, nhưu chỉnh color thì cần 3 cái slider
  bool _incrementHeightBottom = false;
  bool get incrementHeightBottom => _incrementHeightBottom;

  // state giá trị min max của slider
  double? _maxSlider;
  double get maxSlider => _maxSlider!;

  double? _minSlider;
  double get minSlider => _minSlider!;

  // state các giá trị của editor mode có cần lưu và hiển thị slider hay k ? 
  bool _needSave = false;
  bool get needSave => _needSave;

  bool _needChangeSlider = false;
  bool get needChangeSlider => _needChangeSlider;


  // state các chế độ của app
  bool _filterMode = false; 
  bool get filterMode => _filterMode;

  bool _editorMode = false;
  bool get editorMode => _editorMode;

  bool _effectMode = false;
  bool get effectMode => _effectMode;

  bool _textImageMode = false;
  bool get textImageMode => _textImageMode;

  bool _emojiMode = false;
  bool get emojiMode => _emojiMode;



  // state các chế độ của editorMode
  bool _cropEdit = false;
  bool get cropEdit => _cropEdit;

  bool _colorEdit = false;
  bool get colorEdit => _colorEdit;

  bool _contrastEdit = false;
  bool get contrastEdit => _contrastEdit;

  bool _brightnessEdit = false;
  bool get brightnessEdit => _brightnessEdit;

  bool _saturationEdit = false;
  bool get saturationEdit => _saturationEdit;

  bool _sepiaEdit = false;
  bool get sepiaEdit => _sepiaEdit;

  bool _greyScaleEdit = false;
  bool get greyScaleEdit => _greyScaleEdit;

  bool _invertEdit = false;
  bool get invertEdit => _invertEdit;

  // state screen draw , add text ...
  bool _isDrawScreen = false;
  bool get isDrawScreen => _isDrawScreen;

  // 
  FocusNode textFocusNode = FocusNode();
  PainterController? drawController;
  Image? backgroundImage;
  Paint shapePaint = Paint()
  ..strokeWidth = 5
  ..color = Colors.red
  ..style = PaintingStyle.stroke
  ..strokeCap = StrokeCap.round;





  HomeProvider(){
    getGalleryImages();
    onChangeSlider();
  }

  // get image from pexels
  Future<void> getGalleryImages() async {
    var photo = <PhotoGallery>[];
    Random rd = Random();
    var pages = rd.nextInt(200);
    var result = await client.searchPhotos("nature",page: pages,resultsPerPage:10);
    for (var item in result!.items) {
      photo.add(PhotoGallery(
        id: item!.id,
        photographerUrl: item.photographerURL,
        url: item.url,
        photographer: item.photographer,
        src: item.sources['portrait']!.link
      ));
    }
    _photos = photo;
    notifyListeners();
  }

 // handles event change slider
  void onChangeSlider(){
   try{
     timer = Timer.periodic(const Duration(seconds: 3), (timer) {
         carouselController.nextPage(
           duration: const Duration(milliseconds: 1000),
           curve: Curves.ease,
         ).catchError((e)=> {});
     });
   }catch (e){
     carouselController.stopAutoPlay();
     timer.cancel();
   }
  }

  // page index for dot indicator
  void changePage(int index){
    _pageIndex = index;
    notifyListeners();
  }



  //get image from gallery
  void getFromGallery(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  if (pickedFile != null) {
    _imageFile = File(pickedFile.path);
    _bytesImage = Uint8List.fromList(File(_imageFile!.path).readAsBytesSync());
    var newImage = image_lib.decodeImage(await _imageFile!.readAsBytes());
    newImage = image_lib.copyResize(newImage!, width: 600);
    _image = newImage;
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditorScreen(byteImage: _bytesImage!)));
    notifyListeners();
    }else{

    }
  }


    void getFromCamera(BuildContext context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      _bytesImage = Uint8List.fromList(File(_imageFile!.path).readAsBytesSync());
      var newImage = image_lib.decodeImage(await _imageFile!.readAsBytes());
      newImage = image_lib.copyResize(newImage!, width: 600);
      _image = newImage;
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditorScreen(byteImage: _bytesImage!)));
      notifyListeners();
      }else{

      }
  }

    //get image from gallery
  void getImageCreateTemplate(context) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  if (pickedFile != null) {
    _imageFile = File(pickedFile.path);
    _bytesImage = Uint8List.fromList(File(_imageFile!.path).readAsBytesSync());
    var newImage = image_lib.decodeImage(await _imageFile!.readAsBytes());
    newImage = image_lib.copyResize(newImage!, width: 600);
    _image = newImage;
    Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.bottomCenter,duration: const Duration(seconds: 1) , child:  CreateTemPlate()));
    notifyListeners();
    }else{

    }
  }

  void getImageApplyTemplate(context, TemplateModel template) async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
  if (pickedFile != null) {
    _imageFile = File(pickedFile.path);
    _bytesImage = Uint8List.fromList(File(_imageFile!.path).readAsBytesSync());
    var newImage = image_lib.decodeImage(await _imageFile!.readAsBytes());
    newImage = image_lib.copyResize(newImage!, width: 600);
    _image = newImage;
    Navigator.push(context, PageTransition(type: PageTransitionType.scale, alignment: Alignment.topRight,duration: const Duration(seconds: 1) , child: ApplyTemplate(template: template)));
    notifyListeners();
    }else{

    }
  }

  void saveTermImageBytes(imageBytes){
    _bytesImageTerm = imageBytes;
  }

  void onSaveStateImage(context){
    _bytesImage = _bytesImageTerm;
    var newImage = image_lib.decodeImage(_bytesImage!);
    newImage = image_lib.copyResize(newImage!, width: 600);
    _image = newImage;
    notifyListeners();
    ScaffoldMessenger.of(context)
    .showSnackBar(
      const SnackBar(content: Text("Đã lưu lại trạng thái"))
    );
  }

  void onSaveImageToDevice(context) async {
    _bytesImage = _bytesImageTerm;
    notifyListeners();
    var dateTime = DateTime.now();
    final result = await ImageGallerySaver.saveImage(
           _bytesImage!,
           quality: 80,
           name: "THEIN_EDITOR_$dateTime.jpg");
    print(result);
    ScaffoldMessenger.of(context)
    .showSnackBar(
      const SnackBar(content: Text("Đã lưu vào bộ nhớ"))
    );
  }

  // Cut image 
  void croppedImage(imageFile) async{
    _imageFile = imageFile;
    notifyListeners();
    var newImage = image_lib.decodeImage(await imageFile!.readAsBytes());
    newImage = image_lib.copyResize(newImage!, width: 600);
    _image = newImage;
    notifyListeners();
  }

  void setStateEditorMode(){
    if(_colorEdit == true){
      _maxSlider = 255;
      _minSlider = 0;
      _needSave = true;
      _needChangeSlider = true;
      _incrementHeightBottom = true;
    }
    if(_contrastEdit == true){
      _maxSlider = 1;
      _minSlider = -1;
      _needSave = true;
      _needChangeSlider = true;
      _incrementHeightBottom = false;
    }
    if(_brightnessEdit == true){
      _maxSlider = 1;
      _minSlider = -1;
      _needSave = true;
      _needChangeSlider = true;
      _incrementHeightBottom = false;
    }
    if(_saturationEdit == true){
      _maxSlider = 5;
      _minSlider = -1;
      _needSave = true;
      _needChangeSlider = true;
      _incrementHeightBottom = false;
    }
    if(_sepiaEdit == true){
      _maxSlider = 5;
      _minSlider = -5;
      _needSave = true;
      _needChangeSlider = true;
      _incrementHeightBottom = false;
    }
    if(_greyScaleEdit == true){
      _maxSlider = 1;
      _minSlider = 0;
      _needSave = true;
      _needChangeSlider = false;
      _incrementHeightBottom = false;
    }
    if(_invertEdit == true){
      _maxSlider = 1;
      _minSlider = 0;
      _needSave = true;
      _needChangeSlider = false;
      _incrementHeightBottom = false;
      // _currentFilter == 14 ?  _currentFilter = 1 : _currentFilter ++;
    }
    notifyListeners();
  }

  // brightness - độ sáng
  void changeSlider(num sliderA, num? sliderB, num? sliderC){
    if(_colorEdit){
      // slider A => red
      // slider B => green
      // slider C => blue
      _filter = ColorEdit(sliderA.toInt(), sliderB!.toInt(), sliderC!.toInt());
      notifyListeners();
    }
    if(_contrastEdit){
      _filter = ContrastEdit(sliderA);
    }
    if(_brightnessEdit){
      _filter = BrightNessEdit(sliderA);
      notifyListeners();
    }
    if(_saturationEdit){
      _filter = StaturationEdit(sliderA);
      notifyListeners();
    }
    if(_sepiaEdit){
      _filter = SepiaEdit(sliderA);
      notifyListeners();
    }
    notifyListeners();
  }

  void onChangeSliderTemplate(brightness, contrast, saturation, red, green, blue){
    _filter = TemplateFilterEdit(brightness, contrast, saturation, red, green, blue);
    notifyListeners();
  }


  void onGreyScale(){
    _filter = GreyScaleEdit();
    notifyListeners();
  }

    void onInvert(){
    _filter = InvertEdit();
    notifyListeners();
  }


  void changeFilters(filter){
    _filter = filter;
    notifyListeners();
  }

  void setParentMode(context, input){ // set chế độ cho parent mode => bộ lọc, điều chỉnh ..v.v.
    if(input == 0){
      _filterMode = true;
      _editorMode = false;
      _effectMode = false;
      _textImageMode = false;
      _emojiMode = false;
      _incrementHeightBottom = false;
      _needSave = true;
      _needChangeSlider = false;
      _isDrawScreen = false;
    }
    if(input == 1){
      _filterMode = false;
      _editorMode = true;
      _effectMode = false;
      _textImageMode = false;
      _emojiMode = false;
      _incrementHeightBottom = false;
      _needSave = false;
      _needChangeSlider = false;
      _isDrawScreen = false;
    }
    if(input == 2){
      _filterMode = false;
      _editorMode = false;
      _effectMode = true;
      _textImageMode = false;
      _emojiMode = false;
      _incrementHeightBottom = false;
      _needSave = true;
      _needChangeSlider = false;
      _isDrawScreen = false;
    }
    if(input == 3){
      initDrawState();
      _filterMode = false;
      _editorMode = false;
      _effectMode = false;
      _textImageMode = true;
      _emojiMode = false;
      _incrementHeightBottom = false;
      _needSave = false;
      _needChangeSlider = false;
      _isDrawScreen = true;
      Navigator.push(context, PageTransition(type: PageTransitionType.fade, duration: const Duration(seconds: 1), child: const FlutterPainterExample()));
    }
    if(input == 4){
      _filterMode = false;
      _editorMode = false;
      _effectMode = false;
      _textImageMode = false;
      _emojiMode = true;
      _incrementHeightBottom = false;
      _needSave = false;
      _needChangeSlider = false;
      _isDrawScreen = false;
    }
    notifyListeners();
  }

  void setChildMode(input){ // set state mode cho child like color , lux , brightness ...v.v.v
    if(input == 0){
       _cropEdit = true;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = false;
       _sepiaEdit = false;
       _greyScaleEdit = false;
       _invertEdit = false;
    }
    if(input == 1){
      _cropEdit = false;
       _colorEdit = true;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = false;
       _sepiaEdit = false;
       _greyScaleEdit = false;
       _invertEdit = false;
    }
    if(input == 2) {
      _cropEdit = false;
      _colorEdit = false;
      _contrastEdit = true;
      _brightnessEdit = false;
      _saturationEdit = false;
      _sepiaEdit = false;
      _greyScaleEdit = false;
      _invertEdit = false;
    }
    if(input == 3){
      _cropEdit = false;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = true;
       _saturationEdit = false;
       _sepiaEdit = false;
       _greyScaleEdit = false;
       _invertEdit = false;
    }
    if(input == 4){
      _cropEdit = false;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = true;
       _sepiaEdit = false;
       _greyScaleEdit = false;
       _invertEdit = false;
    }
    if(input == 5){
      _cropEdit = false;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = false;
       _sepiaEdit = true;
       _greyScaleEdit = false;
       _invertEdit = false;
    }
    if(input == 6){
      _cropEdit = false;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = false;
       _sepiaEdit = false;
       _greyScaleEdit = true;
       _invertEdit = false;
    }
    if(input == 7) {
      _cropEdit = false;
       _colorEdit = false;
       _contrastEdit = false;
       _brightnessEdit = false;
       _saturationEdit = false;
       _sepiaEdit = false;
       _greyScaleEdit = false;
       _invertEdit = true;
    }
    notifyListeners();
    setStateEditorMode();
  }

  // DRAW IMAGE , TEXT IMage ...
  void initDrawState(){
    drawController = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: Colors.red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )
          )
      );
  }

  void initBackgroundImage() async {
    final image = Image.memory(_bytesImage!);
    backgroundImage = image;
    //drawController!.background = image.backgroundDrawable;
    notifyListeners();
  }

}
