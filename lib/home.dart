import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // bool _isLoggedIn = false;
  // Map _userObj = {};

  Map? _userData;
  AccessToken? _accessToken;

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Facebook Login'),
  //     ),
  //     body: Container(
  //       child: _isLoggedIn
  //           ? Column(
  //               children: [
  //                 Image.network("src"),
  //                 Text("data"),
  //                 TextButton(
  //                   onPressed: () {},
  //                   child: Text('Logout'),
  //                 ),
  //               ],
  //             )
  //           : Center(
  //               child: ElevatedButton(
  //                   onPressed: () async {
  //                     FacebookAuth.instance
  //                         .login(permissions: ["public_profile", "email"]).then(
  //                             (value) {
  //                       FacebookAuth.instance.getUserData().then((userData) {
  //                         setState(() {
  //                           _isLoggedIn = true;
  //                           _userObj = userData;
  //                           print("email =>> ${userData['email']}");
  //                         });
  //                       });
  //                     });
  //                   },
  //                   child: Text('Login with Facebook'))),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Facebook (Logged ' + (_userData == null ? 'out' : 'in') + ')'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              final result = await FacebookAuth.i
                  .login(permissions: ["public_profile", "email"]);

              if (result.status == LoginStatus.success) {
                _accessToken = result.accessToken;

                final requestData = await FacebookAuth.i.getUserData(
                  fields: "email, name",
                );

                setState(() {
                  _userData = requestData;

                  print('result status then : ${result.status}');
                  print('result message then : ${result.message}');
                  print('name : ${_userData!['name']}');
                  print('email : ${_userData!['email']}');
                  // print('picdata : ${_userData!['picture']['data']['url']}');
                  // Image.network(_userData!['picture']['data']['url']);
                });
              } else {
                // print(result.status);
                // print(result.message);
                print('result status else : ${result.status}');
                print('result status else : ${result.message}');
              }
            },
            child: Text('Log In'),
          ),
          // _userData != null
          //     ? Container(
          //         child: Image.network(_userData!['picture']['data']['url']),
          //       )
          //     : Container(),
        ],
      ),
    );
  }
}
