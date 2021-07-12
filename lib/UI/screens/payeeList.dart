import 'package:banking_app/UI/widgets/helperWidgets.dart';
import 'package:flutter/material.dart';
import 'package:banking_app/DB/customer_database.dart';

import 'package:banking_app/model/customer.dart';

class PayeeList extends StatefulWidget {
  @override
  _PayeeListState createState() => _PayeeListState();
}

class _PayeeListState extends State<PayeeList> {
  late List<Customer> customers;
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    refreshCustomers().whenComplete(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future refreshCustomers() async {
    setState(() {
      isLoading = true;
    });
    this.customers = await CustomerDatabase.instance.readAllCustomers();
    print('done');
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: isLoading
          ? Center(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 50),
                child: CircularProgressIndicator.adaptive(),
              ),
            )
          : customers.isEmpty
              ? Container()
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Customers \u{05c3}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontFamily: "Raleway"),
                              ),
                            ),
                          ]),
                    ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: customers.length,
                        itemBuilder: (context, item) {
                          return Dismissible(
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) async {
                              await CustomerDatabase.instance.delete();
                            },
                            key: ValueKey(customers[item].id),
                            background: Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(left: 20),
                              margin: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 4),
                              color: Colors.blueGrey[200],
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            child: Card(
                              elevation: 0,
                              child: Container(
                                height: 110,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(left: 20),
                                          child: Text(
                                            customers[item].name,
                                            style:
                                                textStyle(20, Colors.black54),
                                          ),
                                        ),
                                        Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: 20, left: 10),
                                          child: Column(
                                            children: [
                                              Text(
                                                "current balance",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                  "₹" +
                                                      customers[item]
                                                          .balance
                                                          .toString(),
                                                  style: textStyle(
                                                      20, Colors.blueGrey)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Text(customers[item].email,
                                              style: textStyle(
                                                  15, Colors.blueGrey)),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 12),
                                          child: MaterialButton(
                                            highlightColor:
                                                Colors.blueGrey[200],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(60)),
                                            color: Colors.blueGrey[400],
                                            onPressed: () {
                                              showModalBottomSheet(
                                                  elevation: 10,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  context: context,
                                                  builder: (context) {
                                                    return bottomTile(
                                                      customers[item].id,
                                                      customers[item].name,
                                                      customers[item].balance,
                                                      customers[item].email,
                                                      context,
                                                      formKey,
                                                      customers[item]
                                                          .createdTime,
                                                    );
                                                  });
                                            },
                                            child: Text(
                                              "₹ Transfer",
                                              style: textStyle(
                                                15,
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
    );
  }
}
