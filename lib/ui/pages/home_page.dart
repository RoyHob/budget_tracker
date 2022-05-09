
import 'package:budget_tracker/constants/style.dart';
import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/ui/widgets/add_transaction_dialog.dart';
import 'package:budget_tracker/ui/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final budgetService = Provider.of<BudgetService>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AddTransactionDialog(itemToAdd: (transactionItem) {
                  final budgetService =
                      Provider.of<BudgetService>(context, listen: false);
                  budgetService.addItem(transactionItem);
                });
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: screenSize.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child:
                      Consumer<BudgetService>(builder: (context, value, child) {
                    return CircularPercentIndicator(
                      radius: screenSize.width / 3,
                      lineWidth: 10.0,
                      percent: value.balance / value.budget < 1
                          ? value.balance / value.budget
                          : 1,
                      backgroundColor: Colors.white,
                      center: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          value.balance < value.budget
                              ? Text(
                                  " \$ ${value.balance.toString().split(".")[0]}",
                                  style: balanceValueStyle
                                )
                              : const Text("Out Of Budget", style: TextStyle(color: Colors.red),),
                          const Text(
                            "Balance",
                            style:balanceTextStyle,
                          ),
                          Text("Budget: \$ ${budgetService.budget.toString()}"),
                        ],
                      ),
                      progressColor: Theme.of(context).colorScheme.primary,
                    );
                  }),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Items",
                  style:itemsTitleTextStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Consumer<BudgetService>(builder: (context, value, child) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.items.length,
                    physics: const ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return TransactionCard(item: value.items[index]);
                    },
                  );
                }),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
