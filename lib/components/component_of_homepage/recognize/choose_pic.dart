import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/components/component_of_homepage/recognize/action/action_bar_recognize.dart';
import 'package:scan/components/component_of_homepage/recognize/action/function/crop_image.dart';
import 'package:scan/pages/RecognizerScreen.dart';

class ChoosePic extends StatefulWidget {
  const ChoosePic({super.key});

  @override
  State<ChoosePic> createState() => _ChoosePicState();
}

class _ChoosePicState extends State<ChoosePic> {
  //Image picker
  late ImagePicker imagePicker;
  XFile? xFile = null;
  File? file = null;

  @override
  void initState() {
    imagePicker = ImagePicker();
  }

  //Function choose image
  void ChooseImage() async {
    try {
      //ChangeFile
      xFile = await imagePicker.pickImage(source: ImageSource.gallery);

      // Covert XFile to File
      // if (xFile != null) {
        file = await File(xFile!.path);
        setState(() {});
      // }
    } catch (e) {
      print(e);
    }
  }

  //Function change file
  void ChangeFile(File fileChange) {
    setState(() {
      file = fileChange;
    });
  }

  //Function success image
  void successImage() {
    if (file != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecognizerScreen(file!),
          ));
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Please select a photo',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red[400]),
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: [
            //Icon ok
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.check,
                  size: 25,
                  color: Colors.green[600],
                ))
          ],
        ),
      );
    }
  }

  //Function deleteImage
  void deleteImage() {
    xFile = null;
    file = null;
    setState(() {});
  }

  //Function crop image
  void cropImage() {
    print("king");
    if (file == null) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Please select a photo before crop',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
          ),
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.red[400]),
            child: const Icon(
              Icons.close,
              color: Colors.black,
            ),
          ),
          actions: [
            //Icon ok
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.check,
                  size: 25,
                  color: Colors.green[600],
                ))
          ],
        ),
      );
    } else {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return CropImage(
            changeFile: ChangeFile,
            file: file!,
          );
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Choose and display image

        file == null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Card(
                  // color: Colors.black,
                  child: GestureDetector(
                    onTap: ChooseImage,
                    child: Container(
                      height: MediaQuery.of(context).size.height - 240,
                      child: const Center(
                        child: Text(
                          "Click here to select image",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Card(
                color: Colors.black,
                child: Container(
                  height: MediaQuery.of(context).size.height - 240,
                  child: Image.file(file!),
                ),
              ),

        //Handle Image
        ActionBarReCo(
          chooseImageSuccess: successImage,
          deleteImage: deleteImage,
          cropImage: cropImage,
        ),
      ],
    );
  }
}
