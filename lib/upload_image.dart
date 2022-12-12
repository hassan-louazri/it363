import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:logger/logger.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ImageUploads extends StatefulWidget {
  const ImageUploads({Key? key, this.uid}) : super(key: key);
  final String? uid;

  @override
  ImageUploadsState createState() => ImageUploadsState();
}

class ImageUploadsState extends State<ImageUploads> {
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
  var logger = Logger();
  final userNameController = TextEditingController();




  Future<void> updateProfilePicture(String url, BuildContext context) {
    CollectionReference lastQuestion =
    FirebaseFirestore.instance.collection('Profile');
    return lastQuestion
        .doc(widget.uid)
        .set({
      'profileUrl': url,
    },SetOptions(merge: true))
        .then((value) =>
        Alert(context: context, title: "Profile Picture updated",buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child:  const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],).show())
        .catchError(
            (error) => logger.e("Profile url wasn't added."));
  }

  Future<void> updateUserName(String userName, BuildContext context) {
    CollectionReference lastQuestion =
    FirebaseFirestore.instance.collection('Profile');
    return lastQuestion
        .doc(widget.uid)
        .set({
      'userName': userName,
    },SetOptions(merge: true))
        .then((value) =>
        Alert(context: context, title: "User name updated",buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child:  const Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ],).show())
        .catchError(
            (error) => logger.e("User name not added."));
  }



  Future imgFromGallery(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      } else {
        logger.w('No image selected.');
      }
    });
  }

  Future imgFromCamera(BuildContext context) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile(context);
      } else {
        logger.w('No image selected.');
      }
    });
  }

  Future uploadFile(BuildContext context) async {
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = 'files/$fileName';


      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child('file/');

    UploadTask    upload =   ref.putFile(_photo!);

    upload.then((res) {
      logger.i(res.ref.getDownloadURL().then(
          (url) => updateProfilePicture(url, context)
      )
      );
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile settings '),
      ),

      body:
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background_image_2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 32,
          ),


          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 55,
                backgroundColor: const Color(0xffFDCF09),
                child: _photo != null
                    ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.file(
                    _photo!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.fitHeight,
                  ),
                )
                    : Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)),
                  width: 100,
                  height: 100,
                  child: Icon(
                    Icons.account_box,
                    color: Colors.grey[800],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          TextFormField(
            controller: userNameController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              filled: false,
              hintText: 'Username',
              hintStyle: TextStyle(color: Colors.white, fontFamily: 'Lato'),
              icon: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Icon(Icons.person, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white, width: 3.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide(color: Colors.white, width: 1.0),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              textStyle:
              const TextStyle(fontSize: 20.0, fontFamily: 'Lato'),
              backgroundColor: Colors.blueAccent,
            ),
            onPressed: () => {updateUserName(userNameController.text,context)},
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 50.0,
              ),
              child: Text('Send username'),
            ),
          ),
        ],
      ),
      )
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                 ListTile(
                    leading:  const Icon(Icons.photo_library),
                    title:  const Text('Gallery'),
                    onTap: () {
                      imgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                 ListTile(
                  leading:  const Icon(Icons.photo_camera),
                  title:  const Text('Camera'),
                  onTap: () {
                    imgFromCamera(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}