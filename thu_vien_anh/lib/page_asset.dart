import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_view/photo_view.dart';
import 'package:thu_vien_anh/page_video.dart';


class AssetView extends StatefulWidget {
  const AssetView({super.key, required this.asset, required this.assets});

  final AssetEntity asset;
  final List<AssetEntity> assets;

  @override
  State<AssetView> createState() => _AssetViewState();
}

class _AssetViewState extends State<AssetView> {
  int currentIndex = 0;
  late AssetEntity currentAsset;

  int? index;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.assets.indexOf(widget.asset);
    currentAsset = widget.asset;
    index = (widget.asset.type == AssetType.image) ? 0 : 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(currentAsset.title!),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: () async{
              await PhotoManager.editor.deleteWithIds([widget.asset.id]);
              Navigator.of(context).pop(context);
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: _buidlBody(context, index!),
    );
  }

  _buidlBody(BuildContext context, int index){
    switch(index){
      case 0: return _buildImageView(context);
      case 1: return _buildVideoView(context);
    }
  }

  FutureBuilder<Uint8List> _buildVideoView(BuildContext context) {
    return FutureBuilder<Uint8List>(
      future: currentAsset.thumbnailData.then((value) => value!),
      builder: (context, snapshot) {
        final file = snapshot.data;
        if(file == null)
          return Container();
        else
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VideoPlayer(asset: currentAsset),));
            },
            onHorizontalDragEnd: (details) {
              if (details.primaryVelocity != null) {
                // Lướt sang phải
                if (details.primaryVelocity! > 0 && widget.assets.isNotEmpty) {
                  setState(() {
                    currentIndex =
                        (currentIndex - 1 + widget.assets.length) % widget.assets.length;
                    currentAsset = widget.assets[currentIndex];
                    index = (currentAsset.type == AssetType.image) ? 0 : 1;
                  });
                }

                // Lướt sang trái
                if (details.primaryVelocity! < 0 && widget.assets.isNotEmpty) {
                  setState(() {
                    currentIndex = (currentIndex + 1) % widget.assets.length;
                    currentAsset = widget.assets[currentIndex];
                    index = (currentAsset.type == AssetType.image) ? 0 : 1;
                  });
                }
              }
            },
            child: Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.memory(file, fit: BoxFit.cover,),
                  ),
                    Center(
                      child: Container(
                        color: Colors.blue,
                        child: Icon(Icons.play_arrow, color: Colors.white,),
                      ),
                    ),
                ],
              ),
            ),
          );
      },
    );
  }

  FutureBuilder<File> _buildImageView(BuildContext context) {
    return FutureBuilder<File>(
      future: currentAsset.file.then((value) => value!),
      builder: (context, snapshot) {
        final file = snapshot.data;
        if(file == null)
          return Container();
        else  return GestureDetector(
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity != null) {
              // Lướt sang phải
              if (details.primaryVelocity! > 0 && widget.assets.isNotEmpty) {
                setState(() {
                  currentIndex =
                      (currentIndex - 1 + widget.assets.length) % widget.assets.length;
                  currentAsset = widget.assets[currentIndex];
                  index = (currentAsset.type == AssetType.image) ? 0 : 1;
                });
              }

              // Lướt sang trái
              if (details.primaryVelocity! < 0 && widget.assets.isNotEmpty) {
                setState(() {
                  currentIndex = (currentIndex + 1) % widget.assets.length;
                  currentAsset = widget.assets[currentIndex];
                  index = (currentAsset.type == AssetType.image) ? 0 : 1;
                });
              }
            }
          },
          child: PhotoView(imageProvider: FileImage(file)),
        );
      },
    );
  }
}