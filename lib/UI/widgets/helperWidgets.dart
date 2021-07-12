import 'dart:math';
import 'package:banking_app/DB/customer_database.dart' as cb;
import 'package:banking_app/UI/screens/addCustomers.dart';
import 'package:banking_app/UI/screens/paymentDone.dart';
import 'package:banking_app/model/customer.dart' as c;
import 'package:banking_app/model/transactionModel.dart' as t;
import 'package:banking_app/model/transactionModel.dart';
import 'package:flutter/material.dart';

// Helper Widgets

//appbar
AppBar appbar(String title, remove, BuildContext context) {
  return AppBar(
      toolbarHeight: 70,
      leading: IconButton(
        icon: Icon(Icons.account_balance),
        color: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AddCustomers(context)));
        },
      ),
      backgroundColor: Colors.blueGrey[400],
      title: Text(
        title,
        style: textStyle(20, Colors.white),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.person_add),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => AddCustomers(context)));
          },
        ),
        IconButton(
            icon: Icon(Icons.delete_rounded),
            color: Colors.white,
            onPressed: remove),
      ]);
}

//textStyle
TextStyle textStyle(double fontSize, Color color) {
  return TextStyle(
    color: color,
    fontSize: fontSize,
  );
}

//recent transaction
Padding recentTransactions() {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Center(
      child: Text(
        "recent transactions",
        style: textStyle(20, Colors.black),
      ),
    ),
  );
}

//welcomeUser
Container welcomeUser(String s) {
  return Container(
    decoration: boxDecoration(Colors.blueGrey[100]!, 20),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Text(
        s,
        style: TextStyle(fontSize: 20, color: Color(0xffFF363620)),
      ),
    ),
  );
}

//BoxDecoration
BoxDecoration boxDecoration(Color color, double radius) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(radius),
  );
}

//RoundRectangularBorder
RoundedRectangleBorder roundedRectangleBorder(double radius) {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));
}

Row welcomeUserRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      welcomeUser("Welcome User !"),
    ],
  );
}

//mainActionButtons
SizedBox mainActionButtons(BuildContext context, onItemTapped,
    int selectedIndex, List<Transactions> transactions, isTapped, bool isTap) {
  bool isTaped = false;
  bool temp = true;
  return SizedBox(
    child: Column(
      children: [
        tiles("View Payee List", Icon(Icons.account_circle), () {
          onItemTapped(1);
        }),
        SizedBox(
          height: 20,
        ),
        expandedTile('Recent Transactions', Icon(Icons.account_balance_wallet),
            () {
          temp = isTapped(isTaped);
        }, temp, transactions),
      ],
    ),
  );
}

//tiles
Card tiles(String title, Icon icon, Function func) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: SizedBox(
      height: 70,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text(
                    title,
                    style: textStyle(18, Colors.black),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    func();
                  },
                  icon: icon,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 12,
          ),
          SizedBox(
            height: 2,
            child: Container(
              color: Colors.blueGrey[100],
            ),
          ),
        ],
      ),
    ),
  );
}

//Bottom Navigation Bar
BottomNavigationBar myNavigationBar(int _selectedIndex, _onItemTapped) {
  return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // ignore: deprecated_member_use
            title: Text(
              'Home',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            // ignore: deprecated_member_use
            title: Text(
              'Payees',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            // ignore: deprecated_member_use
            title: Text(
              'Transactions',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.blueGrey),
      ],
      backgroundColor: Colors.blueGrey[400],
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      iconSize: 40,
      onTap: _onItemTapped,
      elevation: 10);
}

Widget bottomTile(int? id, String name, double balance, String email,
    BuildContext context, GlobalKey<FormState> key, DateTime createdTime) {
  TextEditingController moneyController = new TextEditingController();
  return SingleChildScrollView(
    child: AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.decelerate,
      child: Container(
        height: 450,
        child: Column(
          children: [
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, top: 20, bottom: 10),
                    child: Text(
                      "Paying to :",
                      style: textStyle(20, Colors.black),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                //color: Colors.blueGrey,
                height: 90,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.blueGrey[300],
                  elevation: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              name,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          email,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: 190,
                child: Card(
                  elevation: 0,
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (val) {
                              return val!.length > 0
                                  ? null
                                  : "Minimum Amount should be ₹1";
                            },
                            controller: moneyController,
                            decoration: InputDecoration(
                              hintText: "₹ Enter Amount",
                              hintStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.teal,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: MaterialButton(
                              highlightColor: Colors.blueGrey[200],
                              onPressed: () async {
                                if (key.currentState!.validate()) {
                                  var myDouble =
                                      double.parse(moneyController.text);
                                  assert(myDouble is double);
                                  c.Customer customer = c.Customer(
                                      id: id,
                                      name: name,
                                      email: email,
                                      balance: balance + myDouble,
                                      createdTime: createdTime);
                                  t.Transactions transactions = t.Transactions(
                                      name: name,
                                      email: email,
                                      balance: myDouble,
                                      createdTime: DateTime.now());

                                  await cb.CustomerDatabase.instance
                                      .update(customer);

                                  await cb.CustomerDatabase.instance
                                      .createTransaction(transactions);

                                  Future.delayed(Duration(seconds: 1), () {
                                    //addTransactions();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PaymentDone(
                                                moneyController, name)));
                                  });
                                }
                              },
                              child: Text(
                                "Pay Now",
                                style: TextStyle(color: Colors.white),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60)),
                              color: Colors.blueGrey[400],
                            )),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget expandedTile(String title, Icon icon, Function func, bool isTaped,
    List<Transactions> transactions) {
  return Card(
    elevation: 1,
    margin: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  style: textStyle(18, Colors.black),
                ),
              ),
              IconButton(
                onPressed: () {
                  func();
                },
                icon: icon,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2,
          child: Container(
            color: Colors.blueGrey[100],
          ),
        ),
        transactions.isEmpty
            ? Container()
            : isTaped
                ? Container(
                    height: min(280, 400),
                    child: ListView(
                      children: transactions
                          .map((prod) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      prod.name,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "QuickSand",
                                          color: Colors.blueGrey),
                                    ),
                                    //  Spacer(),
                                    Text(
                                      '₹' + '${prod.balance}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "QuickSand",
                                          color: Colors.blueGrey),
                                    ),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  )
                : Container()
      ],
    ),
  );
}
