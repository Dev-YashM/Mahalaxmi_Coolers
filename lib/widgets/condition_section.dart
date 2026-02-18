import 'package:flutter/material.dart';

class ConditionSection extends StatelessWidget {
  const ConditionSection({super.key});

  Widget _chip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40,18,40,18),
      decoration: _decoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Condition",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _chip("Refurbished / Used"),
              _chip("Fully Functional"),
              _chip("Tested OK"),
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
