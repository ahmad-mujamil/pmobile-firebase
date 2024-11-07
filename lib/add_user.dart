import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_text.dart';
import 'package:mob3_jamil_002_uts_xt/component/gradient_button.dart';
import 'home.dart';

class AddUserPage extends StatefulWidget {
  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

  Future<void> _addUser() async {
    final email = _emailController.text.trim();
    final nama = _namaController.text.trim();
    final password = _passwordController.text.trim();

    try {
      // Membuat user baru di Firebase Authentication
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Simpan data user di Firestore
      await _firestore.collection('users').add({
        'nama': nama,
        'email': email,
        'createdAt': Timestamp.now(),
      });

    
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User berhasil ditambahkan!")),
      );

    // Redirect kembali ke halaman Home
      Navigator.of(context).pop(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
      
    } on FirebaseAuthException catch (e) {
      String message = "Failed to add user";
      if (e.code == 'email-already-in-use') {
        message = 'Email sudah terdaftar.';
      } else if (e.code == 'weak-password') {
        message = 'Password terlalu lemah.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TAMBAH USER",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.people,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 30),
            CustomTextInput(labelText: 'Nama', hintText: 'Nama User', icon: Icons.person, controller: _namaController),
            SizedBox(height: 30),
            CustomTextInput(labelText: 'Email', hintText: 'Email User', icon: Icons.mail, controller: _emailController),
            
            SizedBox(height: 30),
            CustomTextInput(labelText: 'Password', hintText: 'Password', icon: Icons.key, controller: _passwordController,isObscure: true,),
          
            SizedBox(height: 40),
            GradientButton(
              onPressed: _addUser,
              text: "Simpan Data",
            ),
          
          ],
        ),
      ),
    );
  }
}