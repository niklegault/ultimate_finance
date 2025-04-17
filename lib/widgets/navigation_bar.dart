import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
      BottomNavigationBarItem(icon: Icon(Icons.money), label: 'Tracking'),
      BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: 'Budget'),
      BottomNavigationBarItem(
        icon: Icon(Icons.track_changes),
        label: 'Investments',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet),
        label: 'Net Worth',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        label: 'Account',
      ),
    ];

    return BottomNavigationBar(
      items: navItems,
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: const Color.fromARGB(255, 2, 129, 23),
      unselectedItemColor: Colors.grey,
    );
  }
}
