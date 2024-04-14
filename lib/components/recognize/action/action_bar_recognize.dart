import 'package:flutter/material.dart';

class ActionBarReCo extends StatefulWidget {
  final Function chooseImageSuccess;
  final Function deleteImage;
  final Function cropImage;

  ActionBarReCo(
      {super.key, required this.chooseImageSuccess, required this.deleteImage, required this.cropImage});

  @override
  State<ActionBarReCo> createState() => _ActionBarReCoState();
}

class _ActionBarReCoState extends State<ActionBarReCo> {



  

  @override
  Widget build(BuildContext context) {
    return //Action bar
        Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Reload image icon
            InkWell(
                onTap: () {
                  widget.deleteImage();
                },
                child: const Icon(
                  Icons.rotate_left,
                  size: 35,
                  color: Colors.white,
                )),

            //Success image icons
            InkWell(
              onTap: () {
                widget.chooseImageSuccess();
              },
              child: const Icon(
                Icons.check,
                size: 50,
                color: Colors.white,
              ),
            ),

            //Clip Image
            InkWell(
              onTap: (){
                widget.cropImage();
              },
              child: const Icon(
                Icons.cut_outlined,
                size: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
