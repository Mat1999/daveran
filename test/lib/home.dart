import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  File? _image;
  List? _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  detectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'Assets/model_unquant.tflite', labels: 'Assets/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image!);
  }

  pickGalleryImg() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    detectImage(_image!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 50),
            Text('coding cafe',
                style: TextStyle(color: Colors.white, fontSize: 20)),
            SizedBox(height: 5),
            Text('Cat dog',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 30)),
            SizedBox(height: 50),
            Center(
              child: _loading
                  ? Container(
                      width: 400,
                      child: Column(
                        children: <Widget>[
                          Image.asset('Assets/ye.png'),
                          SizedBox(height: 50)
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: Image.file(_image!),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _output != null
                              ? Text(
                                  '${_output![0]['label']}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              : Container(),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 2, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Capture a photo',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImg();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 250,
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Select a photo',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
