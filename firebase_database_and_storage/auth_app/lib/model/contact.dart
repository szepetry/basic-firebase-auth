import 'package:firebase_database/firebase_database.dart';

class Contact {
  String _id;
  String _fName;
  String _lName;
  String _phone;
  String _email;
  String _address;
  String _photoUrl;

  //Constructer for contact
  Contact(this._fName, this._lName, this._phone, this._email, this._address,
      this._photoUrl);

  //Constructor for edit
  Contact.withId(this._id, this._fName, this._lName, this._phone, this._email,
      this._address, this._photoUrl);

  Contact.fromSnapshot(DataSnapshot snapshot){
    this._id = snapshot.key;
    this._fName = snapshot.value['fName'];
    this._lName = snapshot.value['lName'];
    this._phone = snapshot.value['phone'];
    this._email = snapshot.value['email'];
    this._address = snapshot.value['address'];
    this._photoUrl = snapshot.value['photoUrl'];
  }

  Map <String, dynamic> toJson(){
    return {
      "fName":_fName,
      "lName":_lName,
      "phone":_phone,
      "email":_email,
      "address":_address,
      "photoUrl":_photoUrl,
    };
  }


  //Getters
  String get id => this._id;
  String get fName => this._fName;
  String get lName => this._lName;
  String get phone => this._phone;
  String get email => this._email;
  String get address => this._address;
  String get photoUrl => this._photoUrl;

  //Setters
  set fName(String fName) {
    this._fName = fName;
  }

  set lName(String lName) {
    this._lName = lName;
  }

  set phone(String phone) {
    this._phone = phone;
  }

  set email(String email) {
    this._email = email;
  }

  set address(String address) {
    this._address = address;
  }

  set photoUrl(String photoUrl) {
    this._photoUrl = photoUrl;
  }


}
