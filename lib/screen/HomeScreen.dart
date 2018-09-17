import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_picker_app/constant/Constant.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  String _imagePath;
  double _headerHeight = 300.0;
  File _file;
  final String _assetImagePath = 'assets/images/ic_no_image.png';
  final String _assetCameraImagePath = 'assets/images/ic_camera.png';

  _HomeScreenState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _imagePath != null
            ? _getImageFromFile(_imagePath)
            : _getImageFromAsset(),
        _getActionButtons(),
        _getLogo(),
      ],
    ));
  }

  Widget _getImageFromAsset() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Container(
        width: double.infinity,
        height: _headerHeight,
        color: Colors.grey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              _assetImagePath,
              width: 60.0,
              height: 60.0,
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Text(
                'No Image Available',
                style: TextStyle(
                  color: Colors.grey[350],
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getImageFromFile(String imagePath) {
    return Padding(
      padding: EdgeInsets.only(bottom: 30.0),
      child: Image.file(
        File(
          imagePath,
        ),
        fit: BoxFit.cover,
        width: double.infinity,
        height: _headerHeight,
      ),
    );
  }

  Widget _getActionButtons() {
    return Positioned(
        top: _headerHeight - 38.0,
        left: 0.0,
        right: 16.0,
        child: Center(
          child: Card(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(20.0, 4.0, 20.0, 4.0),
              width: 180.0,
              height: 68.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => _openGallery(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          _assetImagePath,
                          width: 22.0,
                          height: 22.0,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.grey[350],
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    width: 3.0,
                    color: Colors.grey[350],
                  ),
                  InkWell(
                    onTap: () => _openCamera(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          _assetCameraImagePath,
                          width: 22.0,
                          height: 22.0,
                          fit: BoxFit.cover,
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 4.0),
                          child: Text(
                            'Camera',
                            style: TextStyle(
                              color: Colors.grey[350],
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _getLogo() {
    return Container(
      margin: EdgeInsets.only(top: 220.0),
      alignment: Alignment.center,
      child: Center(
        child: Image.asset(
          'assets/images/ic_flutter_devs_logo.png',
          width: 160.0,
          height: 160.0,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Future _openCamera() async {
    final imagePath = await Navigator.of(context).pushNamed(CAMERA_SCREEN);

    setState(() {
      _imagePath = imagePath;
    });

    if (imagePath != null) {
      print("$imagePath");
    }
  }

  Future<File> _openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _file = image;

    setState(() {
      _imagePath = _file.path;
    });

    if (_imagePath != null) {
      print("$_imagePath");
    }
  }
}
