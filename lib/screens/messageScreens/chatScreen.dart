// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart' hide Config;

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String receiverPhoto;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverPhoto,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  String get chatId {
    List<String> ids = [
      currentUserId,
      widget.receiverId,
    ];

    ids.sort();

    return ids.join("_");
  }

  Future<void> sendMessage() async {
    String text = _messageController.text.trim();

    if (text.isEmpty) return;

    await FirebaseFirestore.instance
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': currentUserId,
      'timestamp': FieldValue.serverTimestamp(),
    });

    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xffF4FAFF),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(.85),
        elevation: 0,
        centerTitle: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.blue.shade100,
                width: 1,
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundImage: widget.receiverPhoto.isNotEmpty
                    ? NetworkImage(widget.receiverPhoto)
                    : null,
                child: widget.receiverPhoto.isEmpty
                    ? const Icon(Icons.person)
                    : null,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.receiverName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  "Online",
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFBEE9FF),
              Color(0xFFEFFBFF),
              Color(0xFFFFFFFF),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: -80,
              right: -50,
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(.25),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: 150,
              left: -60,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                  color: const Color(0xFF81D4FA).withOpacity(.15),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .doc(chatId)
                        .collection('messages')
                        .orderBy(
                          'timestamp',
                          descending: false,
                        )
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      final messages = snapshot.data!.docs;

                      return ListView.builder(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 90,
                          bottom: 12,
                        ),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final doc = messages[index];
                          final data = (doc.data() as Map?) ?? {};
                          final senderId = data['senderId'] as String? ?? '';
                          final isMe = senderId == currentUserId;
                          final timestamp = data['timestamp'];
                          final timeText = timestamp is Timestamp
                              ? DateFormat('hh:mm a').format(timestamp.toDate())
                              : '';

                          return Align(
                            alignment: isMe
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 10,
                              ),
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.75,
                              ),
                              decoration: BoxDecoration(
                                color: isMe
                                    ? const Color(0xFF2563EB)
                                    : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(20),
                                  topRight: const Radius.circular(20),
                                  bottomLeft: Radius.circular(isMe ? 20 : 5),
                                  bottomRight: Radius.circular(isMe ? 5 : 20),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.05),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    data['text'] ?? '',
                                    style: TextStyle(
                                      color: isMe ? Colors.white : Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        timeText,
                                        style: TextStyle(
                                          color: isMe
                                              ? Colors.white70
                                              : Colors.grey,
                                          fontSize: 10,
                                        ),
                                      ),
                                      if (isMe) ...[
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.done_all,
                                          size: 14,
                                          color: Colors.white70,
                                        ),
                                      ]
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(35),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(.12),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.emoji_emotions_outlined,
                            color: Colors.blue.shade400,
                          ),
                          onPressed: () {},
                        ),
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: "Type a message...",
                              hintStyle: GoogleFonts.poppins(
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.attach_file_rounded,
                            color: Colors.blue.shade400,
                          ),
                          onPressed: () {},
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [
                                Color(0xFF4FC3F7),
                                Color(0xFF0288D1),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(.35),
                                blurRadius: 15,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: sendMessage,
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
