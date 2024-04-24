import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pind_app/features/customers/customers_page.dart';
import 'package:pind_app/features/inventory/inventory_page.dart';
import 'package:pind_app/features/requests/requests_page.dart';
import 'package:pind_app/features/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageController = PageController();
  late String userName;
  late String email;
  File? _pickedImage;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    getUserInformations();
  }

  void getUserInformations() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userName = user.displayName != null ? user.displayName! : '';
        email = user.email != null ? user.email! : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: _pickedImage == null
                ? const Icon(
                    Icons.person,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
        title: Text(
          "Olá, ${userName.split(' ')[0]}",
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          const InventoryPage(),
          const RequestsPage(),
          const CustomersPage(),
          ProfilePage(
            userName: userName,
            email: email,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
            pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.ease,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            activeIcon: Icon(Icons.inventory_2_rounded),
            label: "Estoque",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fire_truck_outlined),
            activeIcon: Icon(Icons.fire_truck_rounded),
            label: "Pedidos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handshake_outlined),
            activeIcon: Icon(Icons.handshake_rounded),
            label: "Clientes",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            activeIcon: Icon(Icons.person),
            label: "Perfil",
          ),
        ],
      ),
    );
  }
}
