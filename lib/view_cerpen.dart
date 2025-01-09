import 'package:flutter/material.dart';

class ViewCerpen extends StatelessWidget {
  final String title;
  final String content;

  ViewCerpen({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            // Content
            Text(
              content,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5,  // Spacing between lines
              ),
            ),
            
            SizedBox(height: 20,),
            // Cite Section
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '- Admin',
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}