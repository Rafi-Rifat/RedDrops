import 'package:flutter/material.dart';
import 'posts.dart';

class RequestPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController bloodGroupController = TextEditingController();
  final TextEditingController notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Request Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please fill out the blood request form:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Name',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Contact Number',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Blood Group',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Get the text from the TextFields using the controllers
                String name = nameController.text;
                String contactNumber = contactNumberController.text;
                String bloodGroup = bloodGroupController.text;
                String additionalNotes = notesController.text;

                // Navigate to posts.dart and pass the information as arguments
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PostsPage(
                      name: name,
                      contactNumber: contactNumber,
                      bloodGroup: bloodGroup,
                      additionalNotes: additionalNotes,
                    ),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
