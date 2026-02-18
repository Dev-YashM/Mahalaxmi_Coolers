import 'package:flutter/material.dart';
import 'package:mahalaxmi_coolers/features/login.dart';
import 'package:mahalaxmi_coolers/widgets/hero.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigationToHome();
  }

  void _navigationToHome() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      },
      child: Scaffold(
        body: Container(
          color: Theme.of(context).colorScheme.inversePrimary,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HeroWidget(),
              Text(
                'MAHALAXMI RENTALS',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 32,
                ),
              ),
              Text(
                'Cooling Comfort. Made Affordable.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}