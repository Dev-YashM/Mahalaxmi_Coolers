import 'package:flutter/material.dart';
import 'package:mahalaxmi_coolers/features/home.dart';
import 'package:mahalaxmi_coolers/features/profile.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key, required this.title});
  final String title;

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  int selectedIndex=0;

  final List<Widget> features = const [
    HomeScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(color: Theme.of(context).colorScheme.surface,),
      ),

      body: features[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
          onDestinationSelected: (index){
          setState(() {
            selectedIndex = index;
          });
          },
          indicatorColor: Theme.of(context).colorScheme.primary,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
          ]),
    );
  }
}