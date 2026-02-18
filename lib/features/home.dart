import 'package:flutter/material.dart';
import 'package:mahalaxmi_coolers/widgets/banner_slider.dart';
import 'package:mahalaxmi_coolers/widgets/category_section.dart';
import 'package:mahalaxmi_coolers/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 10),
          BannerSlider(images: ['assets/images/banner/banner1.png','assets/images/banner/banner2.png','assets/images/banner/banner3.png'],),
          SizedBox(height: 20),
          CategorySection(),
          SizedBox(height: 25),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ProductCard(
                  image: "assets/images/cooler/cooler1.png",
                  name: "2'Ft Cooler",
                  price: "Starting At Just ₹599/Month",
                ),
                ProductCard(
                  image: "assets/images/cooler/cooler2.png",
                  name: "3'Ft Cooler",
                  price: "Starting At Just ₹799/Month",
                ),
                ProductCard(
                  image: "assets/images/cooler/cooler3.png",
                  name: "4'Ft Cooler",
                  price: "Starting At Just ₹1099/Month",
                ),
              ],
            ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}
