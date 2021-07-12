import 'package:banking_app/UI/screens/HomePage.dart';
import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:banking_app/model/customer.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/DB/customer_database.dart';

class AddCustomers extends StatefulWidget {
  final BuildContext context;

  AddCustomers(this.context);

  @override
  _AddCustomersState createState() => _AddCustomersState();
}

class _AddCustomersState extends State<AddCustomers> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController balance = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        backgroundColor: Colors.blueGrey[400],
        title: Text(
          "Add Customers",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 150),
          height: 450,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "name",
                        //hoverColor: Colors.blueGrey
                      ),
                      controller: name,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: "email"),
                      controller: email,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(hintText: "balance"),
                      controller: balance,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MaterialButton(
                    onPressed: () async {
                      var myDouble = double.parse(balance.text);
                      assert(myDouble is double);
                      Customer customer = Customer(
                          name: name.text,
                          email: email.text,
                          balance: myDouble,
                          createdTime: DateTime.now());
                      await CustomerDatabase.instance.create(customer);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    child: Text(
                      "ADD",
                      style: textStyle(15, Colors.white),
                    ),
                    color: Colors.blueGrey[400],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
