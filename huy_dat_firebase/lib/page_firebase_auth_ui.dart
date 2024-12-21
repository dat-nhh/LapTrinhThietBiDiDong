import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:huy_dat_firebase/widget_connect_firebase.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      builder: (context) => MaterialApp(
        home: PageSignIn(),
      ),
      errorMessage: "Lỗi",
      connectingMessage: "Đang kết nối",
    );
  }
}

class PageSignIn extends StatelessWidget {
  const PageSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(!snapshot.hasData)
            return SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(clientId: "757802262355-u9qs1jrrnn2bc5rd4qqa5ce8keed04pr.apps.googleusercontent.com"),
                PhoneProviderConfiguration(),
              ],
            );
          return PageHomeAuth();
        },
    );
  }
}

class PageHomeAuth extends StatelessWidget {
  const PageHomeAuth({super.key});

  @override
  Widget build(BuildContext context) {
    User user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Xin chào: ${user.displayName?? user.email?? user.phoneNumber?? ""}"),
            Text("User Id: ${user.uid}"),
            ElevatedButton(
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => PageSignIn(),), (route) => false);
                },
                child: Text("Sign out")
            ),
          ],
        ),
      ),
    );
  }
}


