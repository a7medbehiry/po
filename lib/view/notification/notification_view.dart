import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pet_app/components/widget.dart';
import 'package:pet_app/view/Layout/layout_screen.dart';
import 'package:pet_app/view/notification/widgets/notifications_list_view_builder.dart';

class NotificationView extends StatefulWidget {
  final List<RemoteMessage>? messages; // Receive a list of messages
  const NotificationView({super.key, this.messages});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  Widget build(BuildContext context) {
    final hasMessages = widget.messages != null && widget.messages!.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                headerOfScreen(
                  title: 'Notifications',
                  function: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LayoutScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),

                // Show only if there are no messages
                if (!hasMessages) ...[
                  Image.asset('assets/images/Push notifications-bro 1.png'),
                  const SizedBox(height: 16),
                  const Text(
                    'Your notification center is empty.',
                    style:  TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],

                // Show list of notifications if there are messages
                if (hasMessages)
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: NotificationsListViewBuilder(
                      messages: widget.messages!, // Pass the list of messages
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
