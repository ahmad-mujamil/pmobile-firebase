import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/add_user.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_list.dart';
import 'package:mob3_jamil_002_uts_xt/component/gradient_button.dart';
import 'package:mob3_jamil_002_uts_xt/login.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    // Mendapatkan email dari pengguna yang login
    final User? user = _auth.currentUser;
    final String email = user?.email ?? "No Email";

    return Scaffold(
      appBar: AppBar(
        title: Text('HOME',style: TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Fungsi logout dari Firebase
              await _auth.signOut();

              // Arahkan pengguna ke halaman login setelah logout
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LoginPage()), // Halaman Login
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      "Selamat Datang!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                    "$email",
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            GradientButton(
            onPressed: () {
              // Your onPressed action
              _addUser(context);
            },
            text: 'Tambah User',
            ),
          
            SizedBox(height: 20),
            Divider(),
            Text(
              "Data User",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              // height: MediaQuery.of(context).size.height*0.55,
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('users').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
              
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text("No users found.");
                  }
              
                  var items = snapshot.data!.docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;
                    return {
                      'docid': doc.id,
                      'nama': data['nama'] ?? 'No Name',
                      'email': data['email'] ?? 'No Email',
                      'icon': Icons.person,
                      'has_delete' : email != data["email"],
                    };
                  }).toList();
              
                  return CustomListView(items: items);
                
                  
                },
              ),
            ),

          
          ],
        ),
      ),
    );
  }

  void _addUser(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddUserPage()),
    );
  }
}