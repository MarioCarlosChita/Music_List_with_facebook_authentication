import 'package:estudo_http/Music_Header.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';


class Music_user_perfil extends StatefulWidget{

    final Music_Header  music;
    Music_user_perfil({this.music});
    MusicUser createState()=> MusicUser();

}

class MusicUser extends  State<Music_user_perfil>{
    @override
  Widget build(BuildContext context) {
      return Scaffold(
         body:Center(
              child: Container(
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customWidths: CustomSliderWidths(progressBarWidth: 10),
                  ),
                  min: 10,
                  max: 100,
                  initialValue: 100,
                ),
              ),
         ),
      );
  }
}