import 'package:flutter/material.dart';
import 'package:scan/utils/enums/enum_choose.dart';

class TopBar extends StatefulWidget {


  final typeHanlde typehandle;
  final  Function changeChoose;

   TopBar({super.key, required this.changeChoose, required this.typehandle});

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    return //Top bar
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
                            onTap: () {
                              widget.changeChoose(typeHanlde.SCAN);
                            },
                            child:  Icon(
                              Icons.scanner,
                              size: 30,
                              color:  widget.typehandle == typeHanlde.SCAN ? Colors.blue : Colors.white,
                            )),
                         Text(
                          'Scan',
                          style: TextStyle(color: widget.typehandle == typeHanlde.SCAN ? Colors.blue : Colors.white),
                        )
                      ],
                    ),

                    //Take photo icons
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            widget.changeChoose(typeHanlde.RECOGNIZE);
                          },
                          child:  Icon(
                            Icons.document_scanner,
                            size: 30,
                            color: widget.typehandle == typeHanlde.RECOGNIZE ? Colors.blue : Colors.white,
                          ),
                        ),
                         Text(
                          'Recognize',
                          style: TextStyle(color: widget.typehandle == typeHanlde.RECOGNIZE ? Colors.blue : Colors.white,),
                        )
                      ],
                    ),

                    // //Galery Icon
                    // Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     InkWell(
                    //       onTap: () {},
                    //       child: const Icon(
                    //         Icons.assignment_sharp,
                    //         size: 30,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //     const Text(
                    //       'Enhance',
                    //       style: TextStyle(color: Colors.white),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            );

  }
}