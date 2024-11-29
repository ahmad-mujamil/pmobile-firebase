import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_text.dart';
import 'package:mob3_jamil_002_uts_xt/component/gradient_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  bool isPassword = true;

  bool _isLoading = false;

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        // Create user in Firebase Authentication
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // Save user data to Firestore
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'nim': _nimController.text.trim(),
          'nama': _namaController.text.trim(),
          'email': _emailController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
        });

      
        Navigator.pop(context);
        // Navigate or show success
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Berhasil!')),
        );
    

      } on FirebaseAuthException catch (e) {
        String message = e.message ?? "Registration gagal.";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("REGISTER",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.people,
                size: 100,
                color: Colors.blue,
              ),
              SizedBox(height: 30),
              CustomTextInput(labelText: 'NIM', hintText: 'Nim User', icon: Icons.numbers, controller: _nimController),
              SizedBox(height: 30),
              CustomTextInput(labelText: 'Nama', hintText: 'Nama User', icon: Icons.person, controller: _namaController),
              SizedBox(height: 30),
              CustomTextInput(labelText: 'Email', hintText: 'Email User', icon: Icons.mail, controller: _emailController),
              
              SizedBox(height: 30),
              CustomTextInput(labelText: 'Password', hintText: 'Masukan Password', icon: Icons.lock,
              isObscure: isPassword, 
              controller: _passwordController, showPassword: () {
                setState(() {
                  isPassword = !isPassword;
                });
              },),
          
              SizedBox(height: 40),
              _isLoading ? Center(child: CircularProgressIndicator())
                : GradientButton(
                  onPressed: _registerUser,
                  text: "Register",
                  colorStart: Colors.purple,
                  colorEnd: Colors.indigo,
                ),

            ],
          ),
        ),
      ),
    );
  }
}