import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

import 'home.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File myImage;
  var myImageFile;

  bool isImageLoaded = false;

  var result = '';

  void _getMyImages() async {
    var images = await ImagePickerGC.pickImage(
      context: context,
      source: ImgSource.Gallery,
    );

    setState(() {
      myImage = File(images.path);
      isImageLoaded = true;
    });
  }

  void _readText() async {
    result = '';
    FirebaseVisionImage myImages = FirebaseVisionImage.fromFile(myImage);
    TextRecognizer recognizeText = FirebaseVision.instance.textRecognizer();
    VisionText readText = await recognizeText.processImage(myImages);

    for (TextBlock block in readText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement word in line.elements) {
          setState(() {
            result = result + '  ' + word.text;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluebook'),
        backgroundColor: Colors.pinkAccent[200],
        actions: [
          IconButton(
            icon: Icon(Icons.add_a_photo),
            onPressed: _getMyImages,
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Abel Nicholas'),
              accountEmail: Text('Abelnicholas@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.black,
                radius: 50.0,
              ),
              decoration: BoxDecoration(
                color: Colors.pinkAccent[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Account'),
                leading: Icon(Icons.account_circle),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Settings'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => Home(),
                    ),
                  );
                },
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Location'),
                leading: Icon(Icons.location_on),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Payments'),
                leading: Icon(Icons.account_balance_wallet),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Social'),
                leading: Icon(Icons.people),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Facebook'),
                leading: Icon(FontAwesomeIcons.facebook),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Twitter'),
                leading: Icon(FontAwesomeIcons.twitter),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Linkedin'),
                leading: Icon(FontAwesomeIcons.linkedinIn),
                trailing: Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 100.0),
            isImageLoaded
                ? Center(
                    child: Container(
                      height: 250.0,
                      width: 250.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.pinkAccent[200],
                        image: DecorationImage(
                          image: FileImage(myImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(height: 50.0),
            Text(result),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _readText,
        backgroundColor: Colors.pinkAccent[200],
        tooltip: 'add an image',
        child: Icon(Icons.check),
      ),
    );
  }
}
