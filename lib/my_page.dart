import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  final int _selectedIndex = 0;
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imgTemporary = File(image.path);
      setState(() {
        this.image = imgTemporary;
      });
    } on PlatformException catch (e) {
      print("There is no imagae: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lime,
      appBar: AppBar(
        title: const Text("Tirasol-Activity5"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 10,
                )
              ],
              border: Border.all(width: 5, color: Colors.white10),
            ),
            child: image != null
                ? CircleAvatar(
              radius: 150,
              child: Image.file(
                image!,
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),
            ):
            const Image(
              image: AssetImage('assets/kirk.jpg'),
              fit: BoxFit.cover,
              width: 400,
              height: 400,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: const Text(
              "PICTURE",
              style: TextStyle(
                fontSize: 40,
                color: Colors.black,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.lime,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Camera',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.image), label: 'Photos'),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (int index) async {
          if(index == _selectedIndex) {
            PermissionStatus cameraStatus = await Permission.camera.request();
            if (cameraStatus == PermissionStatus.granted) {
              pickImage(ImageSource.camera);
            } else if (cameraStatus == PermissionStatus.denied) {
              return;
            }
          }else{
            PermissionStatus galleryStatus = await Permission.storage.request();
            if (galleryStatus == PermissionStatus.granted) {
              pickImage(ImageSource.gallery);
            } else if (galleryStatus == PermissionStatus.denied) {
              return;
            }
          }
        },
      ),
    );
  }
}