import 'package:Jarvis/Widget/detailScreen.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> myItemsList = [
    'Text Scanner',
    'Face detection',
    'Barcode Scanner',
    'Label Scanner',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.pinkAccent[200],
      ),
      body: ListView.builder(
        itemCount: myItemsList.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                myItemsList[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(),
                    settings: RouteSettings(arguments: myItemsList[index]),
                  ),
                );
              },
              leading: Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
