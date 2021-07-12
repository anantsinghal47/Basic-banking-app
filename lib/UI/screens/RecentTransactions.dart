import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:banking_app/model/transactionModel.dart';
import 'package:banking_app/DB/customer_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class RecentTransactions extends StatefulWidget {
  @override
  _RecentTransactionsState createState() => _RecentTransactionsState();
}

class _RecentTransactionsState extends State<RecentTransactions> {

  late List<Transactions> transactions;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();



  @override
  void initState() {
    super.initState();
    refreshCustomers();
    //print(customers.length);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshCustomers() async {
    setState(() {
      isLoading = true;
    });
    this.transactions = await CustomerDatabase.instance.readAllTransactions();
    print('Showing Transactions');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),

      child : isLoading? CircularProgressIndicator() : transactions.isEmpty ? Container() : Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 50,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                        "Transactions \u{05c3}" ,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20 ,
                          fontWeight: FontWeight.bold

                        ),
                      ),
                  ),

                ]
            ),
          ),
          ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: transactions.length,
              itemBuilder: (context , item)
              {
                return Card(
                  elevation: 0,
                  child: Container(
                    height: 110,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Text( ( customers[item].id).toString() , style: textStyle(25, Colors.blueGrey),),
                            Padding(
                              padding:  EdgeInsets.only(left: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text( transactions[item].name , style: TextStyle(color: Colors.black54 , fontSize: 20 , fontWeight: FontWeight.w500),),
                                  SizedBox(height: 8,),
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                    Text( new DateFormat("dd-MM-yyyy").format(transactions[item].createdTime).toString() , style: TextStyle(fontSize: 12 ,color: Colors.blueGrey),),
                                    SizedBox(width: 20,),
                                    Text( new DateFormat().add_jm().format(transactions[item].createdTime).toString() , style: TextStyle(fontSize: 12 , color: Colors.blueGrey),),
                                  ],)
                                ],
                              ),
                            ),
                            // Padding(
                            //     padding: EdgeInsets.symmetric(horizontal: 5),
                            // ),
                            Spacer(),
                            //Text("curr:\n bal" , style:  TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),),
                            Padding(
                              padding:  EdgeInsets.only(right: 20 , left: 10),
                              child: Column(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Amount" , style:  TextStyle(fontSize: 12 , fontWeight: FontWeight.bold),),
                                  SizedBox(height: 5,),
                                  Text( "₹" + transactions[item].balance.toString() , style: textStyle(20, Colors.blueGrey)),
                                ],
                              ),
                            ),
                            //Text( transactions[item].email , style: textStyle(15, Colors.blueGrey)),


                          ],
                        ),

                      ],
                    ),
                  ),
                );
              }
          ),

        ],
      ),
    );
  }
}
