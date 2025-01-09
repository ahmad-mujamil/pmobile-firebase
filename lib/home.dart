import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/add_cerpen.dart';
import 'package:mob3_jamil_002_uts_xt/add_user.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_list.dart';
import 'package:mob3_jamil_002_uts_xt/login.dart';

class HomePage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List> _getUser(String userId) async {
    try {
      final userDoc = await _firestore.collection('users').doc(userId).get();
      if (userDoc.exists) {
        return [
                userDoc.data()?["role"],
                userDoc.data()?["nama"]
              ];
      }
    } catch (e) {
      print("Error fetching user role: $e");
    }
    return []; // Return null if role not found
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    if (user == null) {
      return Center(
        child: Text("User not logged in."),
      );
    }

    // final String email = user.email ?? "No Email";
    final String userId = user.uid;



    return FutureBuilder<List?>(
      future: _getUser(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Center(
            child: Text("Failed to fetch user role."),
          );
        }

        final role = snapshot.data![0];
        final nama = snapshot.data![1];

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'HOME',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Fungsi logout dari Firebase
                  await _auth.signOut();

                  // Arahkan pengguna ke halaman login setelah logout
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginPage()),
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
                          "$nama",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Hanya tampilkan tombol jika role adalah admin
                if (role == 'admin') ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                _addUser(context);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.verified_user, size: 40, color: Colors.blue),
                                    SizedBox(height: 8),
                                    Text(
                                      'Verifikasi User',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              onTap: () {
                                _addStory(context);
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: [
                                    Icon(Icons.book, size: 40, color: Colors.green),
                                    SizedBox(height: 8),
                                    Text(
                                      'Tambah Cerpen',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],

                Divider(),
                Text(
                  "Cerpen List",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),

                // Menampilkan list cerpen
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('cerpen').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text("No cerpen found."));
                      }

                      var items = snapshot.data!.docs.map((doc) {
                        var data = doc.data() as Map<String, dynamic>;
                        return {
                          'docid': doc.id,
                          'title': data['title'] ?? 'No Title',
                          'icon': Icons.book,
                          'isi_cerpen' : data['isi_cerpen'] ?? 'Empty Data'
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
      },
    );
  }

  void _addUser(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddUserPage()),
    );
  }

  void _addStory(BuildContext context) {
    // Navigasi ke halaman tambah cerpen
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TambahCerpenPage())
    );
  }
}