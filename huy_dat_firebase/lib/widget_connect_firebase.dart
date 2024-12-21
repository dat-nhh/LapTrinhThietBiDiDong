import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:huy_dat_firebase/firebase_options.dart';
import 'package:huy_dat_firebase/page_sinhvien.dart';

class MyFirebaseConnect extends StatefulWidget {
  final String errorMessage;
  final String connectingMessage;
  final Widget Function(BuildContext context) builder;
  const MyFirebaseConnect({super.key, required this.errorMessage, required this.connectingMessage, required this.builder});

  @override
  State<MyFirebaseConnect> createState() => _MyFirebaseConnectState();
}

class _MyFirebaseConnectState extends State<MyFirebaseConnect> {
  bool ketNoi = false;
  bool loi = false;

  @override
  Widget build(BuildContext context) {
    if (loi) {
      return Container(
        color: Colors.white,
        child: Center(
          child: Text(widget.errorMessage,
            style: TextStyle(fontSize: 16, color: Colors.red),
            textDirection: TextDirection.ltr,
          ),
        ),
      );
    }
    else{
      if(ketNoi == false){
        return Container(
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                Text(widget.connectingMessage,
                  style: TextStyle(fontSize: 16,),
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        );
      }
      else{
        return widget.builder(context);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _KhoiTaoFirebase();
  }

  _KhoiTaoFirebase(){
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then(
            (value) {
              setState(() {
                ketNoi = true;
              });
            }
    ).catchError((onError){
      setState(() {
        loi = true;
      });
    }).whenComplete((){
      print("Hoàn tất kết nối");
    });
  }
}
