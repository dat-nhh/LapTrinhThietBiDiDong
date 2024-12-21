import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:thu_vien_anh/page_asset.dart';

class GalleryApp extends StatefulWidget {
  const GalleryApp({super.key});

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  List<AssetEntity> assets = [];
  int count = 0;

  int index = 0;

  Future<void> truyXuat() async{
    count = await PhotoManager.getAssetCount();
    assets = await PhotoManager.getAssetListRange(
        start: 0,
        end: count
    );
    setState(() {

    });
  }

  @override
  void initState() {
    truyXuat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thư viện"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        automaticallyImplyLeading: false,
        leading: null,
      ),
      body: _buidlBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.image,
              color: Theme.of(context).colorScheme.inversePrimary,),
            icon: Icon(Icons.image, color: Colors.grey,),
            label: "Ảnh",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.photo_album_outlined,
              color: Theme.of(context).colorScheme.inversePrimary,),
            icon: Icon(Icons.photo_album_outlined, color: Colors.grey,),
            label: "Albums",
          ),
        ],
        onTap: (value){
          setState(() {
            index = value;
          });
        },
      ),
    );
  }

  _buidlBody(BuildContext context, int index){
    switch(index){
      case 0: return _buildImages(context);
      case 1: return _buildAlbums(context);
    }
  }

  _buildImages(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async{
        setState(() {
          initState();
        });
      },
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: assets.map(
                (asset) => GestureDetector(
              onTap: () async{
                await Navigator.of(context).push(
                  MaterialPageRoute(builder:
                      (context) => AssetView(asset: asset, assets: assets))
                );
                setState(() {
                  initState();
                });
              },
              child: FutureBuilder<Uint8List>(
                future: asset.thumbnailData.then((value) => value!),
                builder: (context, snapshot) {
                  final file = snapshot.data;
                  if(file == null)
                    return CircularProgressIndicator();
                  else
                    return Expanded(
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.memory(file, fit: BoxFit.cover,),
                            ),
                            if (asset.type == AssetType.video)
                              Center(
                                child: Container(
                                  color: Colors.blue,
                                  child: Icon(Icons.play_arrow, color: Colors.white,),
                                ),
                              ),
                          ],
                        ),
                    );
                },
              ),
            ),
        ).toList(),
      ),
    );
  }

  _buildAlbums(BuildContext context) {
    return Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar
                    (SnackBar(content: Text("Không làm được"),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearSnackBars();
                      },
                      label: "Close",
                    ),
                  ));
                },
                child: Text("Thêm album")
            )
          ],
        ),
      );
  }
}