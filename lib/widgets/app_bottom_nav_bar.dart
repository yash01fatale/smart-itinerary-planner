import 'package:flutter/material.dart';
import '../config/app_routes.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const AppBottomNavBar({
    super.key,
    this.selectedIndex = 2,
  });

  void _navigate(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.messagesScreen,
        );
        break;

      case 1:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.exploreScreen,
        );
        break;

      case 2:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.home,
        );
        break;

      case 3:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.savedTrips,
        );
        break;

      case 4:
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.profileScreen,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: (index) {
        if (index != selectedIndex) {
          _navigate(context, index);
        }
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          label: "Chat",
        ),
        NavigationDestination(
          icon: Icon(Icons.expand_less_outlined),
          label: "Explore",
        ),
        NavigationDestination(
          icon: Icon(Icons.map),
          label: "Trips",
        ),
        NavigationDestination(
          icon: Icon(Icons.bookmark),
          label: "Saved",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
    );
  }
}
