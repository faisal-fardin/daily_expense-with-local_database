import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.black45,
        child: Column(
          children: [
            Container(
              height: 100,
              color: Colors.deepPurple,
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/category');
              },
              title: const Text(
                'Category',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              leading: const Icon(Icons.category,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}
