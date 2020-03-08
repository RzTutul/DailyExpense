import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    home: MyApp(),
    title: "MyApp",
  ));
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  int _amount = 0;
  int _percentage = 0;
  final amountControler = TextEditingController();
  final percentageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Percentage'),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings), title: Text("Setting")),
        BottomNavigationBarItem(icon: Icon(Icons.camera), title: Text("Camera"))
      ]),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.2),
        color: Colors.white70,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  color: Colors.blueAccent.shade200,
                  borderRadius: BorderRadius.circular(20.0)),
              child: Center(
                  child: Text(
                "Amount: ${CalculatePercentage(_amount, _percentage)}",
                style: TextStyle(fontSize: 20, color: Colors.white),
              )),
            ),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01),
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(15.9),
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey.shade500
                  )
                  
                  
                  ),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: amountControler,
                    autofocus: true,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      labelText: "Enter Amount:",
                      //  prefixText: "Enter the Amount: ",
                      prefixIcon: Icon(Icons.attach_money),
                    ),
                  ),
                  TextField(
                    controller: percentageController,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.camera),
                      labelText: "Enter Percentage",
                    ),
                  ),
                  InkWell(
                    child: Container(
                      width: 80,
                      height: 40,
                      margin: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.orange.shade500),
                      child: Center(child: Text("Calculate")),
                    ),
                    onTap: () {
                      setState(() {
                        _amount = int.parse(amountControler.text);
                        _percentage = int.parse(percentageController.text);
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  CalculatePercentage(int amount, int percentage) {
    double per = ((amount * percentage) / 100);
    return per.round();
  }
}
