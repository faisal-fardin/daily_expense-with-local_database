
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.deepPurple,
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Get.toNamed('/category');
              },
              title: const Text('Category'),
              leading: const Icon(Icons.category),
            )
          ],
        ),
      ),
    );
  }
}
