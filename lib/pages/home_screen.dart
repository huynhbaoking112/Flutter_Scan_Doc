import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scan/pages/RecognizerScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Image picker
  late ImagePicker imagePicker;

  @override
  void initState() {
    // TODO: implement initState
    imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //Top bar
            Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Reload icon
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: const Icon(
                              Icons.scanner,
                              size: 30,
                              color: Colors.white,
                            )),
                        const Text(
                          'Scan',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),

                    //Take photo icons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.document_scanner,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Recognize',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),

                    //Galery Icon
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(
                            Icons.assignment_sharp,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          'Enhance',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Camera screen
            Card(
              color: Colors.black,
              child: Container(
                height: MediaQuery.of(context).size.height - 240,
              ),
            ),

            //Action bar
            Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Reload icon
                    InkWell(
                        onTap: () {},
                        child: const Icon(
                          Icons.rotate_left,
                          size: 35,
                          color: Colors.white,
                        )),

                    //Take photo icons
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.camera,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),

                    //Galery Icon
                    InkWell(
                      onTap: () async {
                        //User choose the file image in the gallery
                        XFile? xfile = await imagePicker.pickImage(
                            source: ImageSource.gallery);

                        //Convert XFile to File and handle recognizerScreen
                        if (xfile != null) {
                          File image = File(xfile.path);

                          //Navigation to recognizerScreen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecognizerScreen(image),
                              ));
                        }
                      },
                      child: const Icon(
                        Icons.image,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
