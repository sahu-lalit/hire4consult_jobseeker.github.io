import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _resumeLinkController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  String? _profileImageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      // Initialize plugins here
    });
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final userDoc = await _firestore.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['username'];
          _profileImageUrl = userDoc['profileImageUrl'];
          _resumeLinkController.text = userDoc['resumeLink'];
        });
      }
    }
  }

  Future<void> _updateUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': _nameController.text,
        'profileImageUrl': _profileImageUrl,
        'resumeLink': _resumeLinkController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile updated successfully!')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImageUrl = pickedFile.path;
      });
    }
  }

  // Future<void> _uploadResume() async {
  //   final result = await FilePicker.platform
  //       .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
  //   if (result != null) {
  //     final file = result.files.single;
  //     final user = _auth.currentUser;
  //     if (user != null) {
  //       final storageRef =
  //           _storage.ref().child('resumes/${user.uid}/${file.name}');

  //       if (kIsWeb) {
  //         // For web, use bytes
  //         await storageRef.putData(file.bytes!);
  //       } else {
  //         // For mobile, use file path
  //         await storageRef.putFile(File(file.path!));
  //       }

  //       final downloadUrl = await storageRef.getDownloadURL();
  //       setState(() {
  //         _resumeLinkController.text = downloadUrl;
  //       });
  //       await _firestore.collection('users').doc(user.uid).update({
  //         'resumeLink': _resumeLinkController.text,
  //       });
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Resume uploaded successfully!')),
  //       );
  //     }
  //   }
  // }

  Future<void> _logout() async {
    await _auth.signOut();
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _profileImageUrl != null
                    ? NetworkImage(_profileImageUrl!)
                    : AssetImage('assets/images/default_profile.png')
                        as ImageProvider,
                child: Icon(Icons.camera_alt,
                    size: 50, color: Colors.white.withOpacity(0.5)),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _resumeLinkController,
              decoration: InputDecoration(
                labelText: 'Resume Link',
                suffixIcon: IconButton(
                  icon: Icon(Icons.info_outline),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Please upload your resume on Google Drive and put the link here. This link will be shared with the company when you apply.',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // SizedBox(height: 16),
            // ElevatedButton(
            //   onPressed: _uploadResume,
            //   child: Text('Upload Resume (PDF)'),
            // ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
