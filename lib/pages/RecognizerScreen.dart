import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:scan/utils/listLangue/list_langue.dart';
import 'package:translator/translator.dart';

class RecognizerScreen extends StatefulWidget {
  File image;

  RecognizerScreen(this.image);

  @override
  State<RecognizerScreen> createState() => _RecognizerScreenState();
}

class _RecognizerScreenState extends State<RecognizerScreen> {
  String results = '';
  String translatorResult = '';

  //Translator engine
  late GoogleTranslator translator;
  bool waitTranslator = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HandleImage();
    translator = GoogleTranslator();
  }

  void HandleImage() async {
    final inputImage = InputImage.fromFile(widget.image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);
    results = recognizedText.text;
    for (TextBlock block in recognizedText.blocks) {
      final Rect rect = block.boundingBox;
      final List<Point<int>> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;

      for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }
    }
    setState(() {});
  }

  void tapToCopy() {
    // print("king");
    FlutterClipboard.copy(results).then((value) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Copied successfully',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
            ),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.green[400]),
              child: const Icon(
                Icons.copy,
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
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Recognizer'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //image should be transfer
              Image.file(this.widget.image),

              //Devide
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(color: Colors.black),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //icon scaner
                    const Icon(
                      Icons.document_scanner,
                      color: Colors.white,
                    ),

                    //Text Scaner
                    const Text(
                      "The document",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),

                    //IconCopy
                    GestureDetector(
                      onTap: tapToCopy,
                      child: const Icon(
                        Icons.copy,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),

              //Text from image and translator
              results == ""
                  ? CircularProgressIndicator()
                  : Column(
                      children: [
                        //Text from image
                        Card(
                            color: Colors.grey[200],
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 10),
                              child: Text(
                                results,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )),

                        const SizedBox(
                          height: 15,
                        ),

                        //Translator bar
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          decoration: BoxDecoration(color: Colors.black),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Translator select
                              Container(
                                height: 50,
                                width: 200,
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: DropdownButtonFormField(
                                  items: options.map((String option) {
                                    return DropdownMenuItem(
                                      child: Text(option),
                                      value: option.toLowerCase(),
                                    );
                                  }).toList(),
                                  onChanged: (newValue) async {
                                    setState(() {
                                      waitTranslator = true;
                                    });
                                    var translation = await translator
                                        .translate(results, to: newValue!);

                                    setState(() {
                                      translatorResult = translation.toString();
                                      waitTranslator = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "language",
                                      prefixIcon: Icon(Icons.language)),
                                ),
                              ),

                              //IconTranslator
                              Icon(
                                Icons.translate,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        //Display Translator

                        waitTranslator
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : Card(
                                color: Colors.grey[200],
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 10),
                                  child: Text(
                                    translatorResult,
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                      ],
                    ),

              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
