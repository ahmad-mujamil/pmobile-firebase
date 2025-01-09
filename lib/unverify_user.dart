import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/edit_user';

class UnverifiedUsersPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Unverified Users", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: _firestore
              .collection('users')
              .where('is_verified', isEqualTo: false) // Menampilkan pengguna dengan is_verified false
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator()); // Loading indicator
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No unverified users found."));
            }

            var users = snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return {
                'docid': doc.id,
                'nama': data['nama'] ?? 'No Name',
                'email': data['email'] ?? 'No Email',
                'is_verified': data['is_verified'] ?? false,
              };
            }).toList();

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                var user = users[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(user['nama'], style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(user['email']),
                    trailing: user['is_verified']
                        ? Icon(Icons.check_circle, color: Colors.green)
                        : Icon(Icons.account_box, color: Colors.red),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditPage(docId: user['docid']),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}