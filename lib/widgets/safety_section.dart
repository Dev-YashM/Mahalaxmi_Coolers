import 'package:flutter/material.dart';

class SafetySection extends StatelessWidget {
  const SafetySection({super.key});

  Widget _point(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.arrow_right, size: 20),
          const SizedBox(width: 6),
          Expanded(child: Text(text)),
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
            "Safety & Usage Instructions",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          _point("Cooler is protected with Grounding but that doesnt mean you should touch cooler"),
          _point("Clean upper water tray holes frequently to prevent blockage"),
          _point("If cracking sound or odd behaviour is observed switch off and report on app"),
          _point("If water spray is observed switch off, unplug and clean upper tray holes"),
          _point("Place near window or door (Open Environment) for maximum benefits"),
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
