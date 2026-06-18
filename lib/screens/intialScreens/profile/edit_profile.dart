import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './pick_image.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  bool isLoading = true;
  bool isSaving = false;

  String photoUrl = '';

  File? imageFile;

  List<String> selectedTags = [];

  String travelStyle = 'Adventure';
  String transport = 'Flight';
  String budget = 'Budget';
  String frequency = 'Monthly';

  final List<String> availableTags = [
    '🎒 The Packing Pro',
    '📱 Tech & Navigation',
    '🌍 Responsible & Safe Travel',
    '📸 Travel Photographer',
    '🍜 Food Explorer',
    '✈️ Adventure Explorer',
    '🏖 Beach Lover',
    '🏔 Mountain Explorer',
    '🚗 Road Trip Expert',
  ];

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;

        nameController.text = data['name'] ?? '';
        bioController.text = data['bio'] ?? '';
        photoUrl = data['photoUrl'] ?? '';

        selectedTags =
            List<String>.from(data['travelerTags'] ?? []);

        final prefs =
            data['travelPreferences'] ?? {};

        travelStyle =
            prefs['travelStyle'] ?? 'Adventure';

        transport =
            prefs['transport'] ?? 'Flight';

        budget =
            prefs['budget'] ?? 'Budget';

        frequency =
            prefs['frequency'] ?? 'Monthly';
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> pickImage() async {
  final File? image =
      await ImagePickerService.pickImageFromGallery();

  if (image == null || !mounted) return;

  setState(() {
    imageFile = image;
  });
}

  Future<String?> uploadImage() async {
    if (imageFile == null) return photoUrl;

    try {
      final uid =
          FirebaseAuth.instance.currentUser!.uid;

      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$uid.jpg');

      await ref.putFile(imageFile!);

      return await ref.getDownloadURL();
    } catch (e) {
      debugPrint(e.toString());
      return photoUrl;
    }
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      isSaving = true;
    });

    try {
      final uid =
          FirebaseAuth.instance.currentUser!.uid;

      final imageUrl = await uploadImage();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({
        'name': nameController.text.trim(),
        'bio': bioController.text.trim(),
        'photoUrl': imageUrl,
        'travelerTags': selectedTags,
        'travelPreferences': {
          'travelStyle': travelStyle,
          'transport': transport,
          'budget': budget,
          'frequency': frequency,
        }
      }, SetOptions(merge: true));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text("Profile Updated Successfully"),
          ),
        );

        Navigator.pop(context);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    setState(() {
      isSaving = false;
    });
  }

  Widget buildCard(Widget child) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              GestureDetector(
  onTap: pickImage,
  child: CircleAvatar(
    radius: 60,
    backgroundImage:
        imageFile != null ? FileImage(imageFile!) : null,
    child: imageFile == null
        ? const Icon(Icons.person, size: 60)
        : null,
  ),
),

              const SizedBox(height: 20),

              buildCard(
                Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      validator: (v) =>
                          v!.isEmpty
                              ? "Enter Name"
                              : null,
                      decoration:
                          const InputDecoration(
                        labelText: "Full Name",
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: bioController,
                      maxLines: 4,
                      decoration:
                          const InputDecoration(
                        labelText: "Bio",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              buildCard(
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Traveler Personality",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: availableTags
                          .map((tag) {
                        return FilterChip(
                          label: Text(tag),
                          selected: selectedTags
                              .contains(tag),
                          onSelected: (value) {
                            setState(() {
                              if (value) {
                                selectedTags
                                    .add(tag);
                              } else {
                                selectedTags
                                    .remove(tag);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              buildCard(
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Travel Preferences",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    DropdownButtonFormField(
                      value: travelStyle,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Travel Style",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Adventure',
                          child: Text(
                              '🏔 Adventure'),
                        ),
                        DropdownMenuItem(
                          value: 'Relaxation',
                          child: Text(
                              '🏖 Relaxation'),
                        ),
                        DropdownMenuItem(
                          value: 'Cultural',
                          child:
                              Text('🎭 Cultural'),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          travelStyle =
                              v.toString();
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField(
                      value: transport,
                      decoration:
                          const InputDecoration(
                        labelText:
                            "Transport",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Flight',
                          child:
                              Text('✈️ Flight'),
                        ),
                        DropdownMenuItem(
                          value: 'Train',
                          child:
                              Text('🚆 Train'),
                        ),
                        DropdownMenuItem(
                          value: 'Road Trip',
                          child: Text(
                              '🚗 Road Trip'),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          transport =
                              v.toString();
                        });
                      },
                    ),

                    const SizedBox(height: 15),

                    DropdownButtonFormField(
                      value: budget,
                      decoration:
                          const InputDecoration(
                        labelText: "Budget",
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Budget',
                          child:
                              Text('₹ Budget'),
                        ),
                        DropdownMenuItem(
                          value: 'Mid',
                          child: Text(
                              '₹₹ Mid Range'),
                        ),
                        DropdownMenuItem(
                          value: 'Luxury',
                          child:
                              Text('₹₹₹ Luxury'),
                        ),
                      ],
                      onChanged: (v) {
                        setState(() {
                          budget =
                              v.toString();
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                      isSaving ? null : saveProfile,
                  child: isSaving
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Save Changes",
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}