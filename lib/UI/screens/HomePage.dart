import 'dart:async';
import 'package:banking_app/DB/customer_database.dart';
import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:banking_app/model/transactionModel.dart';
import 'package:banking_app/views/views.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late List<Transactions> transactions;
  bool isLoading = false;
  bool isTap = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool isTapped(isTap) {
    setState(() {
      isTap = !isTap;
    });
    return isTap;
  }

  void remove() async {
    await CustomerDatabase.instance.delete();
    await CustomerDatabase.instance.deleteTransactions();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    refreshCustomers().whenComplete(() {
      setState(() {});
    });
  }

  Future refreshCustomers() async {
    setState(() {
      isLoading = true;
    });
    this.transactions = await CustomerDatabase.instance.readAllTransactions();
    print('Showing home page Transactions');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: myNavigationBar(_selectedIndex, _onItemTapped),
      appBar: appbar("Banking App", remove, context),
      body: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 480)
              return isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                  : mobView(_selectedIndex, context, _onItemTapped,
                      transactions, isTapped, isTap);
            else
              return tabView();
          },
        ),
      ),
    );
  }
}
