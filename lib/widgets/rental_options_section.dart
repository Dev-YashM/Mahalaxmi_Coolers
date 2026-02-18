import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';

class RentalOptionsSection extends StatelessWidget {
  final String daily;
  final String monthly;
  final String seasonal;

  const RentalOptionsSection({
    super.key,
    required this.daily,
    required this.monthly,
    required this.seasonal,
  });

  Widget _optionCard(String title, String price) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title,
              style:
              const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            price,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Rental Options",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _optionCard("Daily", daily)),
              const SizedBox(width: 10),
              Expanded(child: _optionCard("Monthly", monthly)),
              const SizedBox(width: 10),
              FittedBox(child: Expanded(child: _optionCard("Seasonal", seasonal))),
            ],
          )
        ],
      ),
    );
  }

  BoxDecoration _decoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(18),
    boxShadow: [
      BoxShadow(
        blurRadius: 10,
        color: Colors.black.withOpacity(0.05),
        offset: const Offset(0, 4),
      )
    ],
  );
}
