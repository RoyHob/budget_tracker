import 'package:budget_tracker/services/budget_service.dart';
import 'package:budget_tracker/services/theme_service.dart';
import 'package:budget_tracker/ui/pages/home_page.dart';
import 'package:budget_tracker/ui/pages/profile_page.dart';
import 'package:budget_tracker/ui/widgets/add_budget_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  List<Widget> pages = const [
    HomePage(),
    Profile(),
  ];

  List<BottomNavigationBarItem> bottomNavItems = const [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            themeService.darkTheme = !themeService.darkTheme;
          },
          icon: Icon(themeService.darkTheme ? Icons.dark_mode : Icons.wb_sunny),
          //TODO! change only when we click on the bottomNavigationBar
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AddBudgetDialog(budgetToAdd: (budget) {
                        final budgetService =
                            Provider.of<BudgetService>(context, listen: false);
                        budgetService.budget = budget;
                      });
                    });
              },
              icon: const Icon(Icons.attach_money))
        ],
        title: const Center(
          child: Text("Budget Tracker"),
        ),
      ),
      body: pages[_currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPageIndex,
        items: bottomNavItems,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
