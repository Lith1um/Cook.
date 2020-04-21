// Libs
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/profile/profile-wrapper.dart';

// Widgets
import 'package:cook/widgets/recipe-list.dart';
import 'package:cook/widgets/recipe-form.dart';
import 'package:cook/shared/member-feature.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _tabIndex = 0;
  List<Widget> _tabs = <Widget>[
    MemberFeature(
      content: Container(
        child: Center(
          child:Text('your book')
        )
      )
    ),
    RecipeList(),
    MemberFeature(
      content: RecipeForm()
    ),
    ProfileWrapper()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs.elementAt(_tabIndex),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.blue,
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.blue,
          showSelectedItemShadow: true
        ),
        selectedIndex: _tabIndex,
        onSelectTab: (index) => setState(() => _tabIndex = index),
        items: [
          FFNavigationBarItem(
            iconData: Icons.book,
            label: 'My Book',
          ),
          FFNavigationBarItem(
            iconData: Icons.search,
            label: 'Browse',
          ),
          FFNavigationBarItem(
            iconData: Icons.add,
            label: 'Add',
          ),
          FFNavigationBarItem(
            iconData: Icons.person,
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
