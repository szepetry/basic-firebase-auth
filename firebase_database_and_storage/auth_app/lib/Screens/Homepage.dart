import 'package:flutter/material.dart';
import 'add_contact.dart';
import 'view_contact.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  navigateToAddContact() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddContact();
    }));
  }

  navigateToViewContact(id) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      //TODO: Add id
      return ViewContact(id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-waste Management"),
      ),
      body: Container(
          child: FirebaseAnimatedList(
              query: _databaseReference,
              itemBuilder: (BuildContext context, DataSnapshot snapshot,
                  Animation<double> animation, int index) {
                return GestureDetector(
                  onTap: () {
                    navigateToViewContact(snapshot.key);
                  },
                  child: Card(
                    color: Colors.white,
                    elevation: 2.0,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          //TODO: check this
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                          fit: BoxFit.cover,
                          image: snapshot.value['photoUrl'] == "empty"
                              ? AssetImage("assets/logo.png")
                              : NetworkImage(snapshot.value['photoUrl']),
                        ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    "${snapshot.value['fName']} ${snapshot.value['lName']} ")
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              })),
      floatingActionButton: FloatingActionButton(
        onPressed: navigateToAddContact,
        child: Icon(Icons.add),
      ),
    );
  }
}
