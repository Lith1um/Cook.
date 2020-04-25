// Libs
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'package:flutter/material.dart';

// Screens
import 'package:cook/screens/profile/profile-wrapper.dart';
import 'package:cook/screens/recipe-book/favourites.dart';

// Services
import 'package:cook/services/recipes.dart';

// Widgets
import 'package:cook/shared/recipe-list.dart';
import 'package:cook/screens/recipe-book/recipe-book.dart';
import 'package:cook/screens/add/recipe-form.dart';
import 'package:cook/shared/member-feature.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  static final RecipesService _recipesService = RecipesService();

  int _tabIndex = 0;
  List<Widget> _tabs = <Widget>[
    RecipeList(recipesStream: _recipesService.getAllRecipes()),
    MemberFeature(
      content: RecipeBook()
    ),
    MemberFeature(
      content: RecipeForm()
    ),
    MemberFeature(
      content: Favourites()
    ),
    ProfileWrapper()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/images/main-backdrop.png', scale: 5.0),
            repeat: ImageRepeat.repeat
          )
        ),
        child: _tabs.elementAt(_tabIndex)
      ),
      bottomNavigationBar: FFNavigationBar(
        theme: FFNavigationBarTheme(
          barBackgroundColor: Colors.white,
          selectedItemBackgroundColor: Colors.blue[800],
          selectedItemIconColor: Colors.white,
          selectedItemLabelColor: Colors.blue[800],
          showSelectedItemShadow: true
        ),
        selectedIndex: _tabIndex,
        onSelectTab: (index) => setState(() => _tabIndex = index),
        items: [
          FFNavigationBarItem(
            iconData: Icons.search,
            label: 'Browse',
          ),
          FFNavigationBarItem(
            iconData: Icons.book,
            label: 'My Book',
          ),
          FFNavigationBarItem(
            iconData: Icons.add,
            label: 'Add',
          ),
          FFNavigationBarItem(
            iconData: Icons.favorite,
            label: 'Favourites',
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
