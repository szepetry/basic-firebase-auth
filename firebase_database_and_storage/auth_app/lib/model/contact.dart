import 'package:firebase_database/firebase_database.dart';

class Contact {
 // String _id;
  String _pName;
  String _pdes;
  String _plasticName;
  String _price;
  String _photoUrl;

  //Constructer for contact
  Contact(this._pName, this._pdes,this._plasticName,this._price,
      this._photoUrl);

  //Constructor for edit
  Contact.withId(this._pName, this._pdes,this._plasticName,this._price,
      this._photoUrl);

  Contact.fromSnapshot(DataSnapshot snapshot){
    //this._id = snapshot.key;
    this._pName = snapshot.value['pName'];
      this._plasticName = snapshot.value['plasticName'];
    this._pdes = snapshot.value['pdes'];
    this._price=snapshot.value['price'];
    this._photoUrl = snapshot.value['photoUrl'];
  }

  Map <String, dynamic> toJson(){
    return {
      "pName":_pName,
      "pdes":_pdes,
      "plasticName":_plasticName,
      "price":_price,
      "photoUrl":_photoUrl, 
    };
  }
  //Getters
  String get pName => this._pName;
  String get pdes => this._pdes;
  String get plasticName => this._plasticName;
  String get price=> this._price;
  String get photoUrl => this._photoUrl;
  

  //Setters
  set fName(String pName) {
    this._pName = pName;
  }
  set pdes(String pdes) {
    this._pdes = pdes;
  }
   set plasticName(String plasticName) {
    this._plasticName = plasticName;
  }
   set price(String price) {
    this._price = price;
  }
  set photoUrl(String photoUrl) {
    this._photoUrl = photoUrl;
  }


}
