import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/components/component_of_homepage/scan/choose_camera.dart';
import 'package:scan/components/component_of_homepage/recognize/choose_pic.dart';
import 'package:scan/components/component_of_homepage/common/top_bar.dart';
import 'package:scan/pages/RecognizerScreen.dart';
import 'package:scan/utils/enums/enum_choose.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {





  //handleTopBar
  typeHanlde choose = typeHanlde.RECOGNIZE;
  void changeChooseTopBar(typeHanlde typehandle){
    setState(() {
      choose = typehandle;
    });
  }



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            
            //TopBar
            TopBar(typehandle: choose,changeChoose: changeChooseTopBar,),


            //Camera screen
            choose == typeHanlde.RECOGNIZE? ChoosePic() : ChooseCamera(),

            
          ],
        ),
      ),
    );
  }
}
