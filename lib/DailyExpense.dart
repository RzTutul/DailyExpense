import 'package:flutter/material.dart';

class DailyExpensePage extends StatefulWidget {
  @override
  _DailyExpensePageState createState() => _DailyExpensePageState();
}

class _DailyExpensePageState extends State<DailyExpensePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("DashBoard",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.red])),
                      child: Center(
                          child: Text(
                        "Salary",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          // color: Colors.blueAccent.shade400,
                          borderRadius: BorderRadius.circular(20.0),
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.amberAccent, Colors.red])),
                      child: Center(child: Text("Balance")),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 3),
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.blueAccent.shade400,
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.red]),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Center(child: Text("Balance")),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        color: Colors.indigoAccent.shade100,
                        elevation: 7.5,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.1)),
                              child: Text("T"),
                            ),
                          ),
                          title: Text("Xcoder"),
                          subtitle: Text("It"),
                          trailing: Text("..."),
                          onTap: () => debugPrint("$index"),
                        ),
                      );
                    }),
              )
            ],
          ),
        )));

  }
}
