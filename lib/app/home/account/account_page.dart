import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_app/common_widgets/avatar.dart';
import '../../../common_widgets/show_alert_dialog.dart';
import '../../../services/auth.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key key}) : super(key: key);

  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(
      context,
      title: 'Logout',
      content: 'Are you sure that you want to logout?',
      defaultActionText: 'Logout',
      canceldActionText: 'Cancle',
    );
    if (didRequestSignOut == true) {
      _signOut(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(fontSize: 19),
        ),
        backgroundColor: const Color.fromARGB(255, 67, 97, 101),
        actions: <Widget>[
          TextButton(
            onPressed: () => _confirmSignOut(context),
            child: const Text(
              'Logout',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: _buildUserInfo(auth.currentUser),
        ),
      ),
    );
  }

  Widget _buildUserInfo(User user) {
    return Column(
      children: <Widget>[
        Avatar(
          photoUrl: user.photoURL,
          radius: 40,
        ),
        const SizedBox(height: 8),
        if (user.displayName != null)
          Text(
            user.displayName,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
