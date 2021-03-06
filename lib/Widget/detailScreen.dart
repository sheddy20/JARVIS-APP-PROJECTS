import 'dart:io';
import 'dart:async';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  File myImage;
  var myImageFile;

  bool isImageLoaded = false;
  bool isFaceDetected = false;

  String itemSelected = '';

  List<Rect> rect = new List<Rect>();

  var result = '';

  void _getMyImages() async {
    var images = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );

    myImageFile = await images.readAsBytes();
    myImageFile = await decodeImageFromList(myImageFile);

    setState(() {
      myImage = File(images.path);
      isImageLoaded = true;
      isFaceDetected = false;

      myImageFile = myImageFile;
    });
  }

  void launchUrl1() async {
    const url = 'https://facebook.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl2() async {
    const url = 'https://twitter.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl3() async {
    const url = 'https://youtube.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl4() async {
    const url = 'https://github.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl5() async {
    const url = 'https://stackoverflow.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl6() async {
    const url = 'https://medium.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl7() async {
    const url = 'https://freecodecamp.org';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void launchUrl8() async {
    const url = 'https://linkedin.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not Launch url';
    }
  }

  void readText() async {
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

  void scanBarcodes() async {
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

  void myImageLabler() async {
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

  Future myFaceDetector() async {
    FirebaseVisionImage myImages = FirebaseVisionImage.fromFile(myImage);
    FaceDetector faceDetector = FirebaseVision.instance.faceDetector();
    List<Face> faces = await faceDetector.processImage(myImages);

    if (rect.length > 0) {
      rect = new List<Rect>();
    }

    for (Face face in faces) {
      rect.add(face.boundingBox);
    }
  }

  void detectAllFeatures(String myFeatures) {
    switch (myFeatures) {
      case 'Text Scanner':
        readText();
        break;
      case 'Barcode Scanner':
        scanBarcodes();
        break;
      case 'Label Scanner':
        myImageLabler();
        break;
      case 'Face Detection':
        myFaceDetector();
        break;
    }
  }

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
        backgroundColor: Colors.deepPurpleAccent[400],
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
              accountName: Text('Abel Shedrack Nicholas'),
              accountEmail: Text('Shedrackabel42@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('Assets/Images/shedrack.jpg'),
                radius: 50.0,
              ),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent[400],
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Account'),
                onTap: () {},
                leading: Icon(Icons.account_circle),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Settings'),
                onTap: () {},
                leading: Icon(Icons.settings),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Facebook'),
                onTap: launchUrl1,
                leading: Icon(FontAwesomeIcons.facebook),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Medium'),
                onTap: launchUrl6,
                leading: Icon(FontAwesomeIcons.medium),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Twitter'),
                onTap: launchUrl2,
                leading: Icon(FontAwesomeIcons.twitter),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Github'),
                onTap: launchUrl4,
                leading: Icon(FontAwesomeIcons.github),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Youtube'),
                onTap: launchUrl3,
                leading: Icon(FontAwesomeIcons.youtube),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('StackOverflow'),
                onTap: launchUrl5,
                leading: Icon(FontAwesomeIcons.stackOverflow),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('FreeCodeCamp'),
                onTap: launchUrl7,
                leading: Icon(FontAwesomeIcons.freeCodeCamp),
                trailing: Icon(Icons.more_vert),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('LinkedIn'),
                onTap: launchUrl8,
                leading: Icon(FontAwesomeIcons.linkedin),
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
            isImageLoaded && !isFaceDetected
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
                : isImageLoaded && isFaceDetected
                    ? Center(
                        child: Container(
                          child: FittedBox(
                            child: SizedBox(
                              width: myImageFile.width.toDouble(),
                              height: myImageFile.height.toDouble(),
                              child: CustomPaint(
                                painter: FacePainter(
                                  rect: rect,
                                  myImageFile: myImageFile,
                                ),
                              ),
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
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          detectAllFeatures(itemSelected);
        },
        backgroundColor: Colors.deepPurpleAccent[400],
        tooltip: 'Confirm',
        child: Icon(Icons.check),
      ),
    );
  }
}

class FacePainter extends CustomPainter {
  List<Rect> rect;
  var myImageFile;

  FacePainter({@required this.rect, @required this.myImageFile});

  @override
  void paint(Canvas canvas, Size size) {
    if (myImageFile != null) {
      canvas.drawImage(myImageFile, Offset.zero, Paint());
    }

    for (Rect rectangle in rect) {
      canvas.drawRect(
        rectangle,
        Paint()
          ..color = Colors.deepPurpleAccent
          ..strokeWidth = 6.0
          ..style = PaintingStyle.stroke,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    throw UnimplementedError();
  }
}
