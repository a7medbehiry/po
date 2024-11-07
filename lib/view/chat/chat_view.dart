import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:pet_app/components/constant.dart';
import 'package:pet_app/view/chat/const.dart';
import 'package:pet_app/network/local/cache_helper.dart';
import 'package:pet_app/view/chat/models/message_model.dart';
import 'package:pet_app/view/chat/widgets/chat_bubble.dart';

class ChatView extends StatefulWidget {
  final String? receiverEmail;
  final String? receiverName;
  final String? receiverProfileImageUrl;

  const ChatView({
    Key? key,
    this.receiverEmail,
    this.receiverName,
    this.receiverProfileImageUrl,
  }) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final ScrollController _controller = ScrollController();
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollection);
  final TextEditingController controller = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  late String chatId;

  @override
  void initState() {
    super.initState();
    var senderEmail = CacheHelper.getData(key: 'email') ?? '';
    chatId = generateChatId(senderEmail, widget.receiverEmail!);
    print('Chat ID generated: $chatId');
  }

  String generateChatId(String email1, String email2) {
    List<String> emails = [email1, email2];
    emails.sort();
    return emails.join('_');
  }

  Future<void> _pickImage() async {
    print('Picking image...');
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      print('Image picked: ${image.path}');
      _uploadImage(File(image.path));
    } else {
      print('No image selected.');
    }
  }

  Future<void> _uploadImage(File image) async {
    print('Uploading image...');
    try {
      String fileName = path.basename(image.path);
      Reference storageReference =
          FirebaseStorage.instance.ref().child('chat_images/$fileName');
      UploadTask uploadTask = storageReference.putFile(image);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        print(
            'Upload progress: ${snapshot.bytesTransferred}/${snapshot.totalBytes}');
      });

      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      print('Image uploaded successfully. URL: $imageUrl');
      _sendImageMessage(imageUrl);
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _sendImageMessage(String imageUrl) async {
    var senderEmail = CacheHelper.getData(key: 'email');
    var senderName = CacheHelper.getData(key: 'name');
    var senderProfileImageUrl = CacheHelper.getData(key: 'profileImageUrl');
    var receiverToken = await fetchReceiverToken(widget.receiverEmail!);

    print('Sending image message...');
    messages.add({
      'message': imageUrl,
      'userId': senderEmail,
      'receiverId': widget.receiverEmail,
      'chatId': chatId,
      'participants': [senderEmail, widget.receiverEmail],
      'isImage': true,
      kCreatedAt: DateTime.now(),
      'receiverName': widget.receiverName,
      'receiverProfileImageUrl': widget.receiverProfileImageUrl,
      'senderName': senderName, // Added sender's name
      'senderProfileImageUrl':
          senderProfileImageUrl // Added sender's profile image
    }).then((_) {
      print('Image message sent.');
    }).catchError((e) {
      print('Error sending image message: $e');
    });

    if (receiverToken != null) {
      await sendPushNotification(
        receiverToken,
        'New message from $senderEmail',
        'Sent you an image',
      );
    }
  }

  Future<void> sendPushNotification(
      String receiverToken, String title, String body) async {
    const String serverKey =
        'AAAAYR0gcBg:APA91bELjkaqIWIq0UZqjob4c3uwIaKRHkzGfkIsfEJd-z876AU1mq2ug2NjzAmBWzdeACnQ1_MHXZORgFTFxxkPsoe5AA5s55xlntP9OqaQ4bJLppKKVE0o1-4LJjOweOxKyOQDVnXU';

    final message = {
      'to': receiverToken,
      'notification': {
        'title': title,
        'body': body,
      },
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done',
        'message': body,
      },
    };

    print('Sending push notification...');
    try {
      final response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverKey',
        },
        body: jsonEncode(message),
      );

      if (response.statusCode == 200) {
        print('Notification sent successfully');
      } else {
        print(
            'Failed to send notification. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending notification: $e');
    }
  }

  Future<String?> fetchReceiverToken(String receiverEmail) async {
    print('Fetching receiver token...');
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: receiverEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        final token = data['fcmToken'];
        print('Receiver token fetched: $token');
        return token;
      } else {
        print('Receiver document does not exist.');
      }
    } catch (e) {
      print('Error fetching receiver token: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var senderEmail = CacheHelper.getData(key: 'email');

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: primaryColor, width: 2),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          size: 10,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: widget.receiverProfileImageUrl != null &&
                            widget.receiverProfileImageUrl!.isNotEmpty
                        ? NetworkImage(widget.receiverProfileImageUrl!)
                        : const AssetImage('assets/images/default.jpg')
                            as ImageProvider,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    widget.receiverName!,
                    style: const TextStyle(
                        fontSize: 20, fontFamily: 'PoppinsBold'),
                  ),
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: messages
                    .orderBy(kCreatedAt, descending: true)
                    .where('chatId', isEqualTo: chatId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<MessageModel> messagesList =
                        snapshot.data!.docs.map((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      return MessageModel.fromJson(data);
                    }).toList();

                    return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        final message = messagesList[index];
                        return message.userId == senderEmail
                            ? ChatBubble(message: message)
                            : ChatBubbleForFriend(message: message);
                      },
                    );
                  } else if (snapshot.hasError) {
                    print('Error in snapshot: ${snapshot.error}');
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    print('Loading messages...');
                    return SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            const SizedBox(height: 8),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Image.asset(
                        'assets/images/camera.png',
                        height: 24,
                        width: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffFDFDFD),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Type a message ...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        if (controller.text.isNotEmpty) {
                          print('Sending text message: ${controller.text}');
                          var senderEmail = CacheHelper.getData(key: 'email');
                          var senderName = CacheHelper.getData(key: 'name');
                          var senderProfileImageUrl =
                              CacheHelper.getData(key: 'profileImageUrl');
                          var receiverToken =
                              await fetchReceiverToken(widget.receiverEmail!);

                          messages.add({
                            'message': controller.text,
                            'userId': senderEmail,
                            'receiverId': widget.receiverEmail,
                            'chatId': chatId,
                            'participants': [senderEmail, widget.receiverEmail],
                            'isImage': false,
                            kCreatedAt: DateTime.now(),
                            'receiverName': widget.receiverName,
                            'receiverProfileImageUrl':
                                widget.receiverProfileImageUrl,
                            'senderName': senderName, // Added sender's name
                            'senderProfileImageUrl':
                                senderProfileImageUrl // Added sender's profile image
                          }).then((_) {
                            print('Text message sent.');
                          }).catchError((e) {
                            print('Error sending text message: $e');
                          });

                          controller.clear();
                          _controller.animateTo(
                            0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn,
                          );

                          if (receiverToken != null) {
                            await sendPushNotification(
                              receiverToken,
                              'New message from $senderEmail',
                              controller.text,
                            );
                          }
                        } else {
                          print('Text message is empty.');
                        }
                      },
                      child: Image.asset(
                        'assets/images/Arrow-Right-3.png',
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
