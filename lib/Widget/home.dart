import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

class Example extends StatefulWidget {
  Example({Key key}) : super(key: key);
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  File _image;

  Future getMyImage(ImgSource source) async {
    var myImage = await ImagePickerGC.pickImage(
      context: context,
      source: source,
      cameraIcon: Icon(
        Icons.camera_alt,
        color: Colors.pinkAccent[200],
      ),
      cameraText: Text(
        'Select Image From Camera',
        style: TextStyle(color: Colors.black),
      ),
      galleryText: Text(
        'Select Image From Gallery',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
    setState(() {
      _image = myImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.deepPurpleAccent[400],
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getMyImage(ImgSource.Gallery),
                  child: Text('from gallery'.toUpperCase()),
                  color: Colors.pinkAccent[200],
                  textColor: Colors.white,
                ),
              ),
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getMyImage(ImgSource.Camera),
                  child: Text('from camera'.toUpperCase()),
                  color: Colors.pinkAccent[200],
                  textColor: Colors.white,
                ),
              ),
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getMyImage(ImgSource.Both),
                  child: Text('from both'.toUpperCase()),
                  color: Colors.pinkAccent[200],
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
