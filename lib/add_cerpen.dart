import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/component/custom_text.dart';
import 'package:mob3_jamil_002_uts_xt/component/gradient_button.dart';

class TambahCerpenPage extends StatefulWidget {
  @override
  _TambahCerpenPageState createState() => _TambahCerpenPageState();
}

class _TambahCerpenPageState extends State<TambahCerpenPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _isiCerpenController = TextEditingController();


  Future<void> _simpanCerpen() async {
    final String title = _titleController.text.trim();
    final String isiCerpen = _isiCerpenController.text.trim();

    if (title.isEmpty || isiCerpen.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Semua field harus diisi!")),
      );
      return;
    }
    try {
      await _firestore.collection('cerpen').add({
        'title': title,
        'isi_cerpen': isiCerpen,
        'created_at': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Cerpen berhasil disimpan!")),
      );

      Navigator.pop(context); // Kembali ke halaman sebelumnya
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal menyimpan cerpen: $e")),
      );
    } finally {
    
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _isiCerpenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Cerpen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextInput(labelText: 'Judul', hintText: 'Judul Cerpen', icon: Icons.title, controller: _titleController),
          
            SizedBox(height: 30),
        
            Expanded(
              child: CustomTextInput(labelText: 'Isi Cerpen', hintText: 'Isi Cerpen', icon: Icons.book, controller: _isiCerpenController,isExpand: true,maxLines:null ,)
            ),
            SizedBox(height: 40),
            GradientButton(
              onPressed: _simpanCerpen,
              text: "Simpan Cerpen",
            ),
          
          ],
        ),
      ),
    );
  }
}