import 'package:banking_app/UI/screens/HomePage.dart';
import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:flutter/material.dart';

class PaymentDone extends StatefulWidget {
  final amount;
  final name;
  PaymentDone(this.amount, this.name);
  @override
  _PaymentDoneState createState() => _PaymentDoneState();
}

class _PaymentDoneState extends State<PaymentDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Banking App', () {}, context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "Thank You!",
                    style: TextStyle(fontSize: 30, color: Colors.green),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Your Transaction is successful",
                      style: TextStyle(fontSize: 20, color: Colors.green)),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      //child: theImage,
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 3),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: EdgeInsets.all(10),
                          child: IconButton(
                            icon: Icon(Icons.done),
                            onPressed: () {},
                            iconSize: 60,
                            color: Colors.green,
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                              "₹" +
                                  widget.amount.text.toString() +
                                  " transferred to " +
                                  widget.name,
                              style: TextStyle(
                                  fontSize: 20, color: Colors.green))),
                    ),
                  ),
                ],
              )),
              Center(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  highlightColor: Colors.blueGrey[200],
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'Back to home',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
