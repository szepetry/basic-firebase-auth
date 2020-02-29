import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../model/contact.dart';
import 'package:path/path.dart';

class AddContact extends StatefulWidget {
  @override
  _AddContactState createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String _pName = '',
      _pdes = '',
      _plasticName = '',
      _price='',
      _photoUrl = 'empty';

  saveContact(BuildContext context) async {
    if (_pName.isNotEmpty &&
        _pdes.isNotEmpty &&
        _pdes.isNotEmpty) {
      Contact contact = Contact(this._pName, this._pdes, this._plasticName,this._price,
         this._photoUrl);
      await _databaseReference.push().set(contact.toJson());
      navigateToLastScreen(context);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Field required"),
              content: Text("All fields are required"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Close")),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add product details"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    this.pickImage();
                  },
                  child: Center(
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: _photoUrl == "empty"
                              ? AssetImage("assets/cat.jpg")
                              : NetworkImage(_photoUrl),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _pName = value;
                    });
                  },
                  //First name
                  decoration: InputDecoration(
                      labelText: "Product Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              //Last name
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _plasticName = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Plastic Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              //phone
              
              //Address
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _pdes = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Product Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
               Container(
                margin: EdgeInsets.only(top: 20.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _price = value;
                    });
                  },
                  decoration: InputDecoration(
                      labelText: "Product price",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      )),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: RaisedButton(
                  elevation: 5.0,
                  onPressed: () {
                    saveContact(context);
                  },
                  color: Colors.red,
                  child: Text(
                    "Save",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  padding: EdgeInsets.fromLTRB(100, 20, 100, 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future pickImage() async {
    File file = await ImagePicker.pickImage(
      imageQuality: 100,
        source: ImageSource.gallery, maxHeight: 200.0, maxWidth: 200.0);
    String fileName = basename(file.path);
    uploadImage(fileName, file);
  }

  void uploadImage(String fileName, File file) {
    StorageReference _storageReference =
        FirebaseStorage.instance.ref().child(fileName);
    _storageReference.putFile(file).onComplete.then((firebaseFile) async {
      var downloadUrl = await firebaseFile.ref.getDownloadURL();
      setState(() {
        _photoUrl = downloadUrl;
      });
    });
  }

  navigateToLastScreen(BuildContext context) {
    Navigator.of(context).pop();
  }
}
