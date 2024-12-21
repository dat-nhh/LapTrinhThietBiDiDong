import 'package:dat_nhh_63133655_flutter/json/json_data.dart';
import 'package:flutter/material.dart';

class PagePhoto extends StatelessWidget {
  const PagePhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page Photo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: FutureBuilder<List<Photo>>(
        future: getHTTP_content(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
            return Center(child: Text("Lỗi"),);
          if(!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          List<Photo> list = snapshot.data!;
          return GridView.extent(
            maxCrossAxisExtent: 150,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            children: list.map(
                (photo) => Image.network(photo.url!)
            ).toList(),
          );
        },
      ),
    );
  }
}
