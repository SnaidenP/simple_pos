import 'package:flutter/material.dart';
import 'package:simple_pos/src/config/constants.dart';
import 'package:simple_pos/src/login/screen/login_screen.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: Image.asset('assets/logo.png'),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home),
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart),
              color: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.settings),
              color: Colors.white,
            ),
            const Spacer(),
            IconButton(
              onPressed: () => Navigator.push(
                context,
                PageRouteBuilder<Widget>(
                  pageBuilder: (context, _, __) => const LoginPage(),
                ),
              ),
              icon: const Icon(Icons.logout),
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
