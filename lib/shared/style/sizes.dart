import 'package:flutter/cupertino.dart';

class Sizes {
  final BuildContext context;
  late Size? media;

  late double SCREEN_WIDTH;
  late double QUARTER_SCREEN_WIDTH;
  late double HALF_SCREEN_WIDTH;
  late double THREE_QUARTERS_SCREEN_WIDTH;

  late double SCREEN_HEIGHT;
  late double QUARTER_SCREEN_HEIGHT;
  late double HALF_SCREEN_HEIGHT;
  late double THREE_QUARTERS_SCREEN_HEIGHT;

  Sizes({required this.context}){
    media = MediaQuery.of(context).size;

    SCREEN_WIDTH = media!.width;
    QUARTER_SCREEN_WIDTH = SCREEN_WIDTH * 0.25;
    HALF_SCREEN_WIDTH = SCREEN_WIDTH * 0.50;
    THREE_QUARTERS_SCREEN_WIDTH = SCREEN_WIDTH * 0.75;


    SCREEN_HEIGHT = media!.height;
    QUARTER_SCREEN_HEIGHT = SCREEN_HEIGHT * 0.25;
    HALF_SCREEN_HEIGHT = SCREEN_HEIGHT * 0.50;
    THREE_QUARTERS_SCREEN_HEIGHT = SCREEN_HEIGHT * 0.75;
  }

}