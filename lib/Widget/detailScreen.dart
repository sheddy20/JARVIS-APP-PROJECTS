import 'dart:io';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File myImage;
  var myImageFile;

  bool isImageLoaded = false;

  String itemSelected = '';

  var result = '';

  void _getMyImages() async {
    var images = await ImagePicker().getImage(
      source: ImageSource.camera,
    );

    setState(() {
      myImage = File(images.path);
      isImageLoaded = true;
    });
  }

  Future readText() async {
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

  Future scanBarcodes() async {
    result = '';
    FirebaseVisionImage myImages = FirebaseVisionImage.fromFile(myImage);
    BarcodeDetector recognizeBarcode =
        FirebaseVision.instance.barcodeDetector();
    List barcode = await recognizeBarcode.detectInImage(myImages);

    for (Barcode readableCode in barcode) {
      setState(() {
        result = readableCode.displayValue;
      });
    }
  }

  Future myImageLabler() async {
    result = '';
    FirebaseVisionImage myImages = FirebaseVisionImage.fromFile(myImage);
    ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
    List labels = await labeler.processImage(myImages);
    for (ImageLabel label in labels) {
      final String text = label.text;
      final double confidence = label.confidence;
      setState(() {
        result = result + '  ' + '$text       $confidence' + '\n';
      });
      print('$text    -   $confidence');
    }
  }

  Future myFaceDetector() async {}

  @override
  Widget build(BuildContext context) {
    itemSelected = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          itemSelected,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      height: 350.0,
                      width: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
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
            Text(
              result,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: myImageLabler,
        backgroundColor: Colors.pinkAccent[200],
        tooltip: 'add an image',
        child: Icon(Icons.check),
      ),
    );
  }
}
