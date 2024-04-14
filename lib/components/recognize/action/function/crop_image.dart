import 'dart:io';
import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CropImage extends StatefulWidget {
  final File file;
  final Function changeFile;

  const CropImage({super.key, required this.file, required this.changeFile});

  @override
  State<CropImage> createState() => _CropImageState();
}

class _CropImageState extends State<CropImage> {
  late CropController _controller;
  late Uint8List imageData;

  //Property of Crop
  bool _isLoadingImage = false;
  bool _isCropping = false;
  bool _isCircleUi = false;
  bool _isSumbnail = false;

  //Function loading image and create Controller
  void _loadingImage() {
    setState(() {
      _isLoadingImage = true;
    });
    _controller = CropController();
    imageData = widget.file.readAsBytesSync();
    setState(() {
      _isLoadingImage = false;
    });
  }

  @override
  void initState() {
    _loadingImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.white,
        child: Visibility(
          //Nếu không trong quá trình cắt ảnh hoặc tải ảnh thì hiển thị data
          visible: !_isLoadingImage && !_isCropping,
          child: Column(
  
            children: [
              Expanded(
                  flex: 8,
                  child: Stack(
                    children: [

                      //Crop image
                      Crop(
                      image: imageData,
                      controller: _controller,
                      onCropped: (image)  {
                        
                        //Chuyển đổi image sang dạng File bằng File tạm thời ( Không lưu trữ lâu dài trên ứng dụng chỉ tồn tại trên thời gian chạy của ứng dụng)

                        final tempDir = Directory.systemTemp;
                        
                        final tempPath = '${tempDir.path}/temp_image.jpg';

                        final tempFile = File(tempPath);

                       tempFile.writeAsBytesSync(image); 


                        widget.changeFile(tempFile);

                        setState(() {
                          _isCropping = false;
                        });
                        Navigator.pop(context);

                      },
                      // aspectRatio: 4 / 3,
                      initialSize: 0.5,
                      // initialArea: Rect.fromLTWH(240, 212, 800, 600),
                      // initialRectBuilder: (rect) => Rect.fromLTRB(rect.left + 24,
                      //     rect.top + 32, rect.right - 24, rect.bottom - 32),
                      withCircleUi: _isCircleUi,
                      baseColor: Colors.blue.shade900,
                      maskColor: _isSumbnail? Colors.white.withAlpha(200)  :Colors.white.withAlpha(400),
                      progressIndicator: const CircularProgressIndicator(),
                      radius: 20,
                      onMoved: (newRect) {
                        // do something with current crop rect.
                      },
                      onStatusChanged: (status) {
                        // do something with current CropStatus
                      },
                      willUpdateScale: (newScale) {
                        // if returning false, scaling will be canceled
                        return newScale < 5;
                      },
                      cornerDotBuilder: (size, edgeAlignment) =>
                          const DotControl(color: Colors.blue),
                      clipBehavior: Clip.none,
                      // interactive: true,
                      // fixCropRect: true,
                      // formatDetector: (image) {},
                      // imageCropper: myCustomImageCropper,
                      // imageParser: (image, {format}) {},
                    ),

                    //Sumbnail
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: GestureDetector(
                        onTapDown:(_) => setState(() => _isSumbnail = true),
                        onTapUp: (_) => setState(() => _isSumbnail = false),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _isSumbnail ? Colors.grey  :Colors.blue
                          ),
                          child: Icon(Icons.crop_free),
                          
                        ),
                      )
                    )

                    ]
                  )),

              // Chỉnh sửa loại cắt
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          onPressed: () {
                            _isCircleUi = false;
                            _controller.withCircleUi = false;
                            _controller.aspectRatio = 16/9;
                          },
                          icon: Icon(
                            Icons.crop_16_9,
                            size: 30,
                          )),
                      IconButton(
                          onPressed: () {
                             _isCircleUi = false;
                            _controller.withCircleUi = false;
                             _controller.aspectRatio = 7/5;
                          },
                          icon: Icon(Icons.crop_7_5, size: 30)),
                      IconButton(
                          onPressed: () {
                             _isCircleUi = false;
                            _controller.withCircleUi = false;
                             _controller.aspectRatio = 5/4;
                          },
                          icon: Icon(Icons.crop_5_4, size: 30)),
                      IconButton(
                          onPressed: () {
                             _isCircleUi = false;
                              _controller
                                ..withCircleUi = false
                                ..aspectRatio = 1;
                          },
                          icon: Icon(Icons.crop_square, size: 30)),
                      IconButton(
                          onPressed: () {
                             _isCircleUi = false;
                            _controller.withCircleUi = false;
                             _controller.aspectRatio = 3/2;
                          },
                          icon: Icon(Icons.crop_3_2, size: 30)),
                      IconButton(
                          onPressed: () {
                            _isCircleUi = true;
                            _controller.withCircleUi = true;
                          },
                          icon: Icon(Icons.circle_outlined, size: 30)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10,),

              //Đồng ý Cắt
              Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _isCropping = true;
                      });
                      _isCircleUi ? _controller.cropCircle() : _controller.crop();
                    },
                    child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        margin: EdgeInsets.only(left: 20, right: 20,  ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                        child: Text(
                          "Crop it",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 15),
                        )),
                  )),
               const SizedBox(height: 10,),

                  
            ],
          ),

          //Nếu đang trong quá trình tải ảnh hoặc cắt ảnh thì chạy thanh progress
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
