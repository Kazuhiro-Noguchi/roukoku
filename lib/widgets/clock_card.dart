import 'package:flutter/material.dart';
import 'utils.dart';

class ClockCard extends StatelessWidget {
  final DateTime now;

  const ClockCard({super.key, required this.now});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Card(
      color: cs.surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${now.year}年${japaneseEra(now)}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "${now.month}月${now.day}日 ${weekdayJp(now.weekday)}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Text(
              timeString(now),
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
