import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Fungsi untuk menghapus data user dari Firestore berdasarkan ID
  Future<void> deleteUser(String docId) async {
    try {
      await _firestore.collection('users').doc(docId).delete();
    } catch (e) {
      print("Error deleting user: $e");
    }
  }

Future<void> showDeleteConfirmation(BuildContext context, String docId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Konfirmasi Hapus"),
          content: Text("Apakah Anda yakin ingin menghapus user ini?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Menutup dialog jika dibatalkan
              },
              child: Text("Batal"),
            ),
            TextButton(
              onPressed: () {
                deleteUser(docId); // Menghapus user jika dikonfirmasi
                Navigator.of(context).pop(); // Menutup dialog setelah konfirmasi
              },
              child: Text("Hapus"),
            ),
          ],
        );
      },
    );
  }