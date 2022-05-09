
import 'package:budget_tracker/constants/style.dart';
import 'package:budget_tracker/model/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionCard extends StatelessWidget {
  final TransactionItem item;
  const TransactionCard(
      {Key? key,
      required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.05),
              offset: const Offset(0, 25),
              blurRadius: 50,
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        width: MediaQuery.of(context).size.width,
        child: Row(children: [
          Text(
            item.itemTitle,
            style: itemTextStyle,
          ),
          const Spacer(),
          Text(
            (!item.isExpense ? "+ " : "- ") + item.amount.toString(),
            style:itemTextStyle,
          )
        ]),
      ),
    );
  }
}
