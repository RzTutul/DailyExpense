import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:myapp/utils/DailyExpenseDB.dart';

class DailyExpensePage extends StatefulWidget {
  @override
  _DailyExpensePageState createState() => _DailyExpensePageState();
}

class _DailyExpensePageState extends State<DailyExpensePage> {
  final TextEditingController _eNameController = TextEditingController();
  final TextEditingController _eAmountController = TextEditingController();
  final DailyExpenseDB dailyExpenseDB = new DailyExpenseDB();
  ExpensePojo expensePojo;
  List<ExpensePojo> expensePojoList;
  int updateIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _showDailog();
          },
          label: Text('Add'),
          icon: Icon(Icons.add),
          backgroundColor: Colors.pink,
        ),
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
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
                      child: FutureBuilder(
                          future: dailyExpenseDB.getExpenseList(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              expensePojoList = snapshot.data;
                              return ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: expensePojoList == null
                                      ? 0
                                      : expensePojoList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    ExpensePojo expensePojo =
                                        expensePojoList[index];
                                    return Card(
                                      color: Colors.indigoAccent.shade100,
                                      elevation: 7.5,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.1)),
                                            child: Text("T"),
                                          ),
                                        ),
                                        title: Text('${expensePojo.e_name}'),
                                        subtitle:
                                            Text('${expensePojo.e_amount}'),
                                        trailing: Text("..."),
                                        onTap: () => debugPrint("$index"),
                                      ),
                                    );
                                  });
                            }
                            return new CircularProgressIndicator();
                          }))
                ],
              ),
            )));
  }

  // void _showDailog() async {
  //   await showDialog<String>(
  //     context: context,
  //     child: new AlertDialog(
  //       contentPadding: const EdgeInsets.all(16.0),
  //       content: new Row(
  //         children: <Widget>[
  //           new Expanded(
  //             child: new TextField(
  //               autofocus: true,
  //               decoration: new InputDecoration(
  //                   labelText: 'Expense Name',
  //                   hintText: 'eg. flexiload',
  //                 ),
  //             ),
  //           )
  //         ],
  //       ),
  //       actions: <Widget>[
  //         new FlatButton(
  //             child: const Text('CANCEL'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             }),
  //         new FlatButton(
  //             child: const Text('Save'),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             })
  //       ],
  //     ),
  //   );
  // }

  _showDailog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      "Add Your Expense!",
                      style: TextStyle(
                          fontSize: 20, color: Colors.orangeAccent.shade400),
                    )),
                    TextField(
                      controller: _eNameController,
                      autofocus: true,
                      maxLength: 20,
                      decoration: InputDecoration(
                          labelText: "Expense Name", hintText: 'eg. flexiload'),
                    ),
                    TextField(
                      controller: _eAmountController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: "Amount",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SizedBox(
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancle",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        ),
                        SizedBox(
                          child: RaisedButton(
                            onPressed: () {
                              setState(() {
                                _saved(context);
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: const Color(0xFF1BC0C5),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _saved(BuildContext context) {
    if (expensePojo == null) {
      if (_eNameController.text.isEmpty) {
        final snackBar = SnackBar(content: Text('Message Empty'));
        Scaffold.of(context).showSnackBar(snackBar);
      }

      else
      {
        ExpensePojo expensePojo = new ExpensePojo(e_name: _eNameController.text,e_amount: int.parse(_eAmountController.text) );
        setState(() {
          dailyExpenseDB.insertExpense(expensePojo).then((id) =>
        {_eNameController.clear(),_eAmountController.clear(), print('Expense Added to Db ${id}')});
        });

      }
    }
  }
}
