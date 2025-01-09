import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/view_cerpen.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, dynamic>> items;  // Accepting dynamic data
  final bool isVerified;
  
  // Constructor to accept dynamic data
  CustomListView({required this.items, this.isVerified =false});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];  // Retrieve dynamic data for each item
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(10),
            title: Text(
              item['title'],
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("Author : Admin"),
            onTap: () { 
              if(isVerified){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewCerpen(title: item["title"],content :item["isi_cerpen"])));
              }else{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Akses Ditolak"),
                      content: Text(
                          "Anda belum terverifikasi. Silakan hubungi admin untuk memverifikasi akun Anda."),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  }
                );
              }
            },
            leading: Icon(
              item['icon'],
              color: Colors.blueAccent,
            ),
                                 
          ),
          
        );
      },
    );
  }
}