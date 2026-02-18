import 'package:flutter/material.dart';
import '../../widgets/cooler_image_slider.dart';
import '../../widgets/cooler_info_section.dart';
import '../../widgets/condition_section.dart';
import '../../widgets/rental_options_section.dart';
import '../../widgets/safety_section.dart';
import '../../widgets/note_section.dart';
import '../core/theme/app_colors.dart';

class CoolerDetailsScreen extends StatelessWidget {
  const CoolerDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Cooler Details',
          style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.surface),
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(color: Theme.of(context).colorScheme.surface,),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [

            /// 🔥 IMAGE SLIDER
            CoolerImageSlider(
              images: [
                "assets/images/cooler/cooler1.png",
                "assets/images/cooler/cooler2.png",
                "assets/images/cooler/cooler3.png",
              ],
            ),

            SizedBox(height: 18),

            CoolerInfoSection(
              title: "2Ft Dessert Cooler",
              rentAmount: "Starting ₹159/day",
            ),

            SizedBox(height: 16),
            ConditionSection(),

            SizedBox(height: 16),
            RentalOptionsSection(
              daily: "159/day",
              monthly: "399/Month",
              seasonal: "699/Season",
            ),

            SizedBox(height: 16),
            SafetySection(),

            SizedBox(height: 16),
            NoteSection(),

            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
