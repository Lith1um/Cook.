// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cook/screens/authenticate/authenticate.dart';
import 'package:cook/screens/home/home.dart';

// Models
import 'package:cook/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
