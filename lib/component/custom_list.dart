import 'package:flutter/material.dart';
import 'package:mob3_jamil_002_uts_xt/view_cerpen.dart';

class CustomListView extends StatelessWidget {
  final List<Map<String, dynamic>> items;  // Accepting dynamic data
  
  // Constructor to accept dynamic data
  CustomListView({required this.items});
  
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];  // Retrieve dynamic data for each item
        return Card(
          elevation: 5,
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ViewCerpen(title: item["title"],content :item["isi_cerpen"])));
              } ,
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