import 'package:flutter/material.dart';

import 'component/component.dart';
import 'component/order_categories_widget.dart';
import 'component/top_order_widget.dart';

class HomePage extends StatelessWidget {
  int balance;
  String username;
  HomePage({Key? key,required this.balance,required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0,right:10.0,top:40.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              titleHeader("Hello $username"),
              //divider(),
              balanceCard(balance: balance),
              const voucherCard(),
              titleSubHeader("Pekerjaan Populer"),
              const TopOrderCategoriesWidget(),
              titleSubHeader("Order Pekerjaan"),
              const OrderCategoriesWidget()
            ]),
      ),

    );
  }

}
