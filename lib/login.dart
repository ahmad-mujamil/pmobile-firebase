import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_text.dart';
import 'package:mob3_jamil_002_uts_xt/component/divider.dart';
import 'package:mob3_jamil_002_uts_xt/component/gradient_button.dart';
import 'package:mob3_jamil_002_uts_xt/home.dart';
import 'package:mob3_jamil_002_uts_xt/register.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isPassword = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login Berhasil!")),
      );
      // Navigate to home screen if login is successful
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'User tidak terdaftar.';
          break;
        case 'wrong-password':
          errorMessage = 'Password tidak valid.';
          break;
        default:
          errorMessage = 'Login gagal. Silahkan coba kembali.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar atau Ikon di atas TextInput
            Icon(
              Icons.lock,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 30),
            // TextField untuk email
            CustomTextInput(labelText: 'Email', hintText: 'Masukan Email', icon: Icons.email, controller: _emailController,maxLines: 1,),
            SizedBox(height: 16),
            // TextField untuk password
            CustomTextInput(labelText: 'Password', hintText: 'Masukan Password', icon: Icons.lock, maxLines: 1,
            isObscure: isPassword, 
            controller: _passwordController, showPassword: () {
              setState(() {
                isPassword = !isPassword;
              });
            },),
            
            SizedBox(height: 30),
            // Tombol Login lebar
            GradientButton(
              onPressed: _login,
              text: "Login",
            ),
            SizedBox(height: 30),
            TextDivider(text: "Belum punya akun ?"),
            SizedBox(height: 20),
            GradientButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterPage()));
              },
              text: "Register Here",
              colorStart: Colors.purple,
              colorEnd: Colors.indigo,
            ),
          ],
        ),
      ),
    );
  }
}