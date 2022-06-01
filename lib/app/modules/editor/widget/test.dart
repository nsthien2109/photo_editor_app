// ignore_for_file: deprecated_member_use
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_painter/flutter_painter.dart';
import 'dart:ui' as ui;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:photo_editor_pro/app/core/values/colors.dart';
import 'package:photo_editor_pro/app/modules/editor/dialog/render_image.dart';
import 'package:photo_editor_pro/app/modules/editor/dialog/select_sticker_image.dart';
import 'package:photo_editor_pro/app/providers/home_provider.dart';
import 'package:photo_editor_pro/app/widgets/slider_draw_image.dart';
import 'package:provider/provider.dart';

class FlutterPainterExample extends StatefulWidget {
  const FlutterPainterExample({Key? key}) : super(key: key);

  @override
  _FlutterPainterExampleState createState() => _FlutterPainterExampleState();
}

class _FlutterPainterExampleState extends State<FlutterPainterExample> {
  static const Color red = Color(0xFFFF0000);
  FocusNode textFocusNode = FocusNode();
  late PainterController controller;
  ui.Image? backgroundImage;
  Paint shapePaint = Paint()
    ..strokeWidth = 5
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  static const List<String> listEmoijs = [
    "assets/images/Emojis/Emoji-Psck-1.png",
    "assets/images/Emojis/Emoji-Psck-2.png",
    "assets/images/Emojis/Emoji-Psck-3.png",
    "assets/images/Emojis/Emoji-Psck-4.png",
    "assets/images/Emojis/Emoji-Psck-5.png",
    "assets/images/Emojis/Emoji-Psck-6.png",
    "assets/images/Emojis/Emoji-Psck-7.png",
    "assets/images/Emojis/Emoji-Psck-8.png",
    "assets/images/Emojis/Emoji-Psck-9.png",
    "assets/images/Emojis/Emoji-Psck-10.png",
    "assets/images/Emojis/Emoji-Psck-11.png",
    "assets/images/Emojis/Emoji-Psck-12.png",
    "assets/images/Emojis/Emoji-Psck-13.png",
    "assets/images/Emojis/Emoji-Psck-14.png",
    "assets/images/Emojis/Emoji-Psck-15.png",
    "assets/images/Emojis/Emoji-Psck-16.png",
    "assets/images/Emojis/Emoji-Psck-17.png",
    "assets/images/Emojis/Emoji-Psck-18.png",
    "assets/images/Emojis/Emoji-Psck-19.png",
    "assets/images/Emojis/Emoji-Psck-20.png",
    "assets/images/Emojis/Emoji-Psck-21.png",
    "assets/images/Emojis/Emoji-Psck-22.png",
    "assets/images/Emojis/Emoji-Psck-23.png",
    "assets/images/Emojis/Emoji-Psck-24.png",
    "assets/images/Emojis/Emoji-Psck-25.png",
    "assets/images/Emojis/Emoji-Psck-26.png",
    "assets/images/Emojis/Emoji-Psck-27.png",
    "assets/images/Emojis/Emoji-Psck-28.png"
  ];


  @override
  void initState() {
    super.initState();
    controller = PainterController(
        settings: PainterSettings(
            text: TextSettings(
              focusNode: textFocusNode,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: red, fontSize: 18),
            ),
            freeStyle: const FreeStyleSettings(
              color: red,
              strokeWidth: 5,
            ),
            shape: ShapeSettings(
              paint: shapePaint,
            ),
            scale: const ScaleSettings(
              enabled: true,
              minScale: 1,
              maxScale: 5,
            )));
    textFocusNode.addListener(onFocus);
    initBackground();
  }


  void initBackground() async {
    var imageBytes = Provider.of<HomeProvider>(context, listen: false).bytesImage;
    final image =  await MemoryImage(imageBytes).image;
    setState(() {
      backgroundImage = image;
      controller.background = image.backgroundDrawable;
    });
  }

  void onFocus() {
    setState(() {});
  }

  Widget buildDefault(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, kToolbarHeight),
          child: ValueListenableBuilder<PainterControllerValue>(
              valueListenable: controller,
              child: const Text("Chỉnh sửa",style: TextStyle(color: Colors.white)),
              builder: (context, _, child) {
                return AppBar(
                  elevation: 0,
                  backgroundColor: secondColor,
                  iconTheme: const IconThemeData(
                    color: Colors.white
                  ),
                  title: child,
                  actions: [
                    // Delete the selected drawable
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.trash,
                      ),
                      onPressed: controller.selectedObjectDrawable == null
                          ? null
                          : removeSelectedDrawable,
                    ),
                    // Delete the selected drawable
                    IconButton(
                      icon: const Icon(
                        Icons.flip,
                      ),
                      onPressed: controller.selectedObjectDrawable != null &&
                              controller.selectedObjectDrawable is ImageDrawable
                          ? flipSelectedImageDrawable
                          : null,
                    ),
                    // Redo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowClockwise,
                      ),
                      onPressed: controller.canRedo ? redo : null,
                    ),
                    // Undo action
                    IconButton(
                      icon: const Icon(
                        PhosphorIcons.arrowCounterClockwise,
                      ),
                      onPressed: controller.canUndo ? undo : null,
                    ),
                  ],
                );
              }),
        ),
        // Generate image
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            PhosphorIcons.floppyDisk,
          ),
          backgroundColor: secondColor,
          tooltip: "Xem trước",
          onPressed: renderAndDisplayImage,
        ),
        body: Container(
          color: secondColor,
          child: Stack(
            children: [
              if (backgroundImage != null)
              Positioned.fill(
                  child: Center(
                    child: AspectRatio(
                      aspectRatio:
                          backgroundImage!.width / backgroundImage!.height,
                      child: FlutterPainter(
                        controller: controller,
                      ),
                    ),
                  ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (context, _, __) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          constraints: const BoxConstraints(
                            maxWidth: 400,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                            color: Colors.black,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (controller.freeStyleMode != FreeStyleMode.none) ...[
                                SliderDrawImage(
                                  controller: controller, 
                                  label: "Kích thước", 
                                  onChangeSlider: setFreeStyleStrokeWidth, 
                                  maxSlider: 25, 
                                  minSlider: 2,
                                  value: controller.freeStyleStrokeWidth,
                                ),
                                if (controller.freeStyleMode == FreeStyleMode.draw)
                                  SliderDrawImage(
                                    controller: controller, 
                                    label: "Màu sắc", 
                                    onChangeSlider: setFreeStyleColor, 
                                    maxSlider: 359.99, 
                                    minSlider: 0,
                                    value: HSVColor.fromColor(controller.freeStyleColor).hue,
                                    color: controller.freeStyleColor,
                                  ),
                              ],
                              if (textFocusNode.hasFocus) ...[
                                SliderDrawImage(
                                    controller: controller, 
                                    label: "Cỡ chữ", 
                                    onChangeSlider: setTextFontSize, 
                                    maxSlider: 96, 
                                    minSlider: 8,
                                    value: controller.textStyle.fontSize ?? 14
                                ),
                                SliderDrawImage(
                                    controller: controller, 
                                    label: "Màu sắc", 
                                    onChangeSlider: setTextColor, 
                                    maxSlider: 359.99, 
                                    minSlider: 0,
                                    value: HSVColor.fromColor(controller.textStyle.color ?? red).hue,
                                    color: controller.textStyle.color
                                )
                              ],
                              if (controller.shapeFactory != null) ...[
                                SliderDrawImage(
                                  controller: controller, 
                                  label: "Kích thước", 
                                  onChangeSlider: (value) => setShapeFactoryPaint((controller.shapePaint ?? shapePaint).copyWith(strokeWidth: value)), 
                                  maxSlider: 25, 
                                  minSlider: 2,
                                  value: controller.shapePaint?.strokeWidth ?? shapePaint.strokeWidth,
                                ),
                                SliderDrawImage(
                                    controller: controller, 
                                    label: "Màu sắc", 
                                    onChangeSlider: (hue) => setShapeFactoryPaint((controller.shapePaint ?? shapePaint).copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor())), 
                                    maxSlider: 359.99, 
                                    minSlider: 0,
                                    value: HSVColor.fromColor((controller.shapePaint ?? shapePaint).color).hue,
                                    color: (controller.shapePaint ?? shapePaint).color
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 1, child: Text("Tô màu",style: TextStyle(
                                      color: Colors.white
                                    ))),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: Switch(     
                                          activeTrackColor: lightGrey,
                                          activeColor: secondColor,
                                          inactiveTrackColor: lightGrey,                                    
                                          value: (controller.shapePaint ?? shapePaint).style == PaintingStyle.fill,
                                          onChanged: (value) => setShapeFactoryPaint((controller.shapePaint ?? shapePaint).copyWith(style: value ? PaintingStyle.fill : PaintingStyle.stroke))
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: ValueListenableBuilder(
          valueListenable: controller,
          builder: (context, _, __) => Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    PhosphorIcons.eraser,
                    color: controller.freeStyleMode == FreeStyleMode.erase
                        ? Colors.pink
                        : Colors.white,
                  ),
                  onPressed: toggleFreeStyleErase,
                ),
                IconButton(
                  icon: Icon(
                    PhosphorIcons.scribbleLoop,
                    color: controller.freeStyleMode == FreeStyleMode.draw
                        ? Colors.pink
                        : Colors.white,
                  ),
                  onPressed: toggleFreeStyleDraw,
                ),
                IconButton(
                  icon: Icon(
                    PhosphorIcons.textT,
                    color: textFocusNode.hasFocus
                        ? Colors.pink
                        : Colors.white,
                  ),
                  onPressed: addText,
                ),
                IconButton(
                  icon: const Icon(
                    PhosphorIcons.sticker,
                    color: Colors.white,
                  ),
                  onPressed: addSticker,
                ),
                if (controller.shapeFactory == null)
                  PopupMenuButton<ShapeFactory?>(
                    tooltip: "Add shape",
                    itemBuilder: (context) => <ShapeFactory, String>{
                      LineFactory(): "Đường thẳng",
                      ArrowFactory(): "Mũi tên",
                      DoubleArrowFactory(): "Mũi tên 2 chiều",
                      RectangleFactory(): "Chữ nhật",
                      OvalFactory(): "Tròn",
                    }.entries.map((e) => PopupMenuItem(
                            value: e.key,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  getShapeIcon(e.key),
                                  color: Colors.black,
                                ),
                                Text(" ${e.value}")
                              ],
                            )))
                        .toList(),
                    onSelected: selectShape,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        getShapeIcon(controller.shapeFactory),
                        color: controller.shapeFactory != null
                            ? Colors.pink
                            : Colors.white,
                      ),
                    ),
                  )
                else
                  IconButton(
                    icon: Icon(
                      getShapeIcon(controller.shapeFactory),
                      color: Colors.pink,
                    ),
                    onPressed: () => selectShape(null),
                  ),
              ],
            ),
          ),
        )
      );
  }

  @override
  Widget build(BuildContext context) {
    return buildDefault(context);
  }








  static IconData getShapeIcon(ShapeFactory? shapeFactory) {
    if (shapeFactory is LineFactory) return PhosphorIcons.lineSegment;
    if (shapeFactory is ArrowFactory) return PhosphorIcons.arrowUpRight;
    if (shapeFactory is DoubleArrowFactory) {
      return PhosphorIcons.arrowsHorizontal;
    }
    if (shapeFactory is RectangleFactory) return PhosphorIcons.rectangle;
    if (shapeFactory is OvalFactory) return PhosphorIcons.circle;
    return PhosphorIcons.polygon;
  }

  void undo() {
    controller.undo();
  }

  void redo() {
    controller.redo();
  }

  void toggleFreeStyleDraw() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.draw
        ? FreeStyleMode.draw
        : FreeStyleMode.none;
  }

  void toggleFreeStyleErase() {
    controller.freeStyleMode = controller.freeStyleMode != FreeStyleMode.erase
        ? FreeStyleMode.erase
        : FreeStyleMode.none;
  }

  void addText() {
    if (controller.freeStyleMode != FreeStyleMode.none) {
      controller.freeStyleMode = FreeStyleMode.none;
    }
    controller.addText();
  }

  void addSticker() async {
    final imageLink = await showDialog<String>(
        context: context,
        builder: (context) => const SelectStickerImageDialog(
              emojis : listEmoijs,
        ));
    if (imageLink == null) return;
    controller.addImage(
        await AssetImage(imageLink).image, const Size(100, 100));
  }

  void setFreeStyleStrokeWidth(double value) {
    controller.freeStyleStrokeWidth = value;
  }

  void setFreeStyleColor(double hue) {
    controller.freeStyleColor = HSVColor.fromAHSV(1, hue, 1, 1).toColor();
  }

  void setTextFontSize(double size) {
    setState(() {
      controller.textSettings = controller.textSettings.copyWith(
          textStyle:
              controller.textSettings.textStyle.copyWith(fontSize: size));
    });
  }

  void setShapeFactoryPaint(Paint paint) {
    setState(() {
      controller.shapePaint = paint;
    });
  }

  void setTextColor(double hue) {
    controller.textStyle = controller.textStyle
        .copyWith(color: HSVColor.fromAHSV(1, hue, 1, 1).toColor());
  }

  void selectShape(ShapeFactory? factory) {
    controller.shapeFactory = factory;
  }

  void renderAndDisplayImage() async {
    if (backgroundImage == null) return;
    final backgroundImageSize = Size(
        backgroundImage!.width.toDouble(), backgroundImage!.height.toDouble());

    final imageFuture = controller
        .renderImage(backgroundImageSize)
        .then<Uint8List?>((ui.Image image) => image.pngBytes);
    context.read<HomeProvider>().saveTermImageBytes(await imageFuture);
    context.read<HomeProvider>().onSaveStateImage(context);
    showDialog(
        context: context,
        builder: (context) => RenderedImageDialog(imageFuture: imageFuture));
  }

  void removeSelectedDrawable() {
    final selectedDrawable = controller.selectedObjectDrawable;
    if (selectedDrawable != null) controller.removeDrawable(selectedDrawable);
  }

  void flipSelectedImageDrawable() {
    final imageDrawable = controller.selectedObjectDrawable;
    if (imageDrawable is! ImageDrawable) return;

    controller.replaceDrawable(
        imageDrawable, imageDrawable.copyWith(flipped: !imageDrawable.flipped));
  }
}