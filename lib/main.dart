import 'package:estudo_http/screen_pages/Index_Page.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

void main()  =>runApp(
    MaterialApp(

        home: MainIndex(),
        debugShowCheckedModeBanner:false,

    )
);

class MainIndex extends StatefulWidget{
    @override
  State<StatefulWidget> createState() {
      return Index();
  }
}
