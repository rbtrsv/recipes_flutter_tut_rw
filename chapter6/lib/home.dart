import 'package:flutter/material.dart';

import 'screens/explore_screen.dart';
import 'screens/recipes_screen.dart';
import 'screens/grocery_screen.dart';

import 'package:provider/provider.dart';
import 'models/models.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  // int _selectedIndex = 0;

  static List<Widget> pages = <Widget>[
    ExploreScreen(),
    RecipesScreen(),
    // TODO: Replace with grocery screen
    const GroceryScreen(),
  ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  // ignore: lines_longer_than_80_chars
  Widget build(BuildContext context) {
    // TODO: Wrap inside a Consumer Widget
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       'Fooderlich',
    //       style: Theme.of(context).textTheme.headline6,
    //     ),
    //   ),
    //   body: pages[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     selectedItemColor:
    //     Theme.of(context).textSelectionTheme.selectionColor,
    //     currentIndex: _selectedIndex,
    //     onTap: _onItemTapped,
    //     items: const [
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.explore),
    //         label: 'Explore',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.book),
    //         label: 'Recipes',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: Icon(Icons.list),
    //         label: 'To Buy',
    //       ),
    //     ],
    //   ),
    // );
    return Consumer<TabManager>(builder: (context, tabManager, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Fooderlich',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        // TODO: Replace body
        // body: pages[tabManager.selectedTab],
        body: IndexedStack(
          index: tabManager.selectedTab,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor:
              Theme.of(context).textSelectionTheme.selectionColor,
          currentIndex: tabManager.selectedTab,
          onTap: (index) {
            tabManager.goToTab(index);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Recipes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'To Buy',
            ),
          ],
        ),
      );
    });
  }
}
