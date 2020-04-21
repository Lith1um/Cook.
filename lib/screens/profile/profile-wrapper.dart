// Libs
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:cook/screens/authenticate/authenticate.dart';
import 'package:cook/screens/profile/profile.dart';

// Models
import 'package:cook/models/user.dart';

class ProfileWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<User>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return Profile();
    }
  }
}
