import 'package:banking_app/UI/screens/RecentTransactions.dart';
import 'package:banking_app/UI/screens/payeeList.dart';
import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:banking_app/model/transactionModel.dart';
import 'package:flutter/material.dart';

//Mobile View
Widget mobView(int _selectedIndex, BuildContext context, onItemTapped,
    List<Transactions> transactions, isTapped, bool isTap) {
  List<Widget> _widgetOptions = <Widget>[
    Column(
      children: [
        SizedBox(
          height: 40,
        ),
        welcomeUserRow(),
        SizedBox(
          height: 40,
        ),
        mainActionButtons(context, onItemTapped, _selectedIndex, transactions,
            isTapped, isTap),
        SizedBox(
          height: 10,
        ),
      ],
    ),
    PayeeList(),
    RecentTransactions(),
  ];
  return Container(
    child: _widgetOptions.elementAt(_selectedIndex),
  );
}

//Tablet view
Widget tabView() {
  return Container();
}
