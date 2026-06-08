import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.showBackButton = false,
  });
  @override
  Widget build(BuildContext context) {
    
    return AppBar(
      automaticallyImplyLeading: true,
      elevation: 0,
      backgroundColor: Colors.white,
      title: const Row(
        children: [
          Icon(
            Icons.explore,
            color: Color(0xff006591),
          ),
          SizedBox(width: 8),
          Text(
            "TravelWise AI",
            style: TextStyle(
              color: Color(0xff006591),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://i.pravatar.cc/300",
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}