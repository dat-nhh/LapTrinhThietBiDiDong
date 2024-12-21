import 'package:dat_nhh_63133655_flutter/ListView.dart';
import 'package:dat_nhh_63133655_flutter/Route.dart';
import 'package:dat_nhh_63133655_flutter/app_state_ex/getx/get_counter.dart';
import 'package:dat_nhh_63133655_flutter/app_state_ex/getx/getbuilder_counter.dart';
import 'package:dat_nhh_63133655_flutter/app_state_ex/list_provider/gio_hang_app.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/home_page_fruitstore.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/page_dssp_admin.dart';
import 'package:dat_nhh_63133655_flutter/fruit_store/page_home_firebase_fruit.dart';
import 'package:dat_nhh_63133655_flutter/json/json_list.dart';
import 'package:dat_nhh_63133655_flutter/main.dart';
import 'package:dat_nhh_63133655_flutter/page_counter.dart';
import 'package:dat_nhh_63133655_flutter/profile/page-profile-63133655.dart';
import 'package:dat_nhh_63133655_flutter/rss/pages/page_rss_simple.dart';
import 'package:flutter/material.dart';


class pageHome extends StatelessWidget {
  const pageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("My App"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              _buildButton(context, label: "My Home", destination: MyHomePage()),
              _buildButton(context, label: "My Profile", destination: myProfile()),
              _buildButton(context, label: "List View", destination: ListViewPage()),
              _buildButton(context, label: "Route", destination: FirstPage()),
              _buildButton(context, label: "List Provider", destination: GioHangApp()),
              _buildButton(context, label: "Counter State Provider", destination: CounterStateProvider()),
              _buildButton(context, label: "Get Counter", destination: PageGetxCounter()),
              _buildButton(context, label: "Simple State", destination: SimpleStateHome()),
              _buildButton(context, label: "Fruit Store", destination: AppFruitStore()),
              _buildButton(context, label: "Photo JSON", destination: PagePhoto()),
              _buildButton(context, label: "RSS", destination: RssApp()),
              _buildButton(context, label: "Fruit Store Firebase", destination: FruitFirebaseApp()),
              _buildButton(context, label: "Fruit Store Admin", destination: FruitStoreAdmin()),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildButton(BuildContext context, {required String label, required Widget destination}) {
    return Container(
              width: 200,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => destination)
                    );
                  },
                  child: Text(label)
              ),
            );
  }
}
