import 'package:flutter/material.dart';

class MiniCalendarCard extends StatelessWidget {
  final int monthOffset; // -1 for prev, +1 for next
  final DateTime? baseDate; // Base date for month calculation
  const MiniCalendarCard({super.key, required this.monthOffset, this.baseDate});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final base = baseDate ?? now;
    final targetDate = DateTime(base.year, base.month + monthOffset);
    final year = targetDate.year;
    final month = targetDate.month;

    final first = DateTime(year, month, 1);
    final last = DateTime(year, month + 1, 0);
    final start = first.weekday % 7;

    final days = <Widget>[];
    for (int i = 0; i < start; i++) {
      days.add(const SizedBox());
    }

    for (int d = 1; d <= last.day; d++) {
      final isToday = d == now.day && month == now.month && year == now.year;
      final weekday = DateTime(year, month, d).weekday % 7; // 0=Sun

      Color textColor;
      if (weekday == 0) {
        textColor = Colors.redAccent;
      } else if (weekday == 6) {
        textColor = Colors.blueAccent;
      } else {
        textColor = Theme.of(context).colorScheme.onSurface;
      }

      days.add(
        Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              alignment: Alignment.center,
              decoration: isToday
                  ? const BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    )
                  : null,
              child: Text(
                '$d',
                style: TextStyle(
                  color: isToday ? Colors.white : textColor,
                  fontSize: isToday ? 14 : 12,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final weekdaysShort = ['日', '月', '火', '水', '木', '金', '土'];

    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Column(
          children: [
            Text(
              '$month月',
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(fontSize: 13),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: weekdaysShort.map((w) {
                Color c = Theme.of(context).colorScheme.onSurface;
                if (w == '日') c = Colors.redAccent.withValues(alpha: 0.7);
                if (w == '土') c = Colors.blueAccent.withValues(alpha: 0.7);
                return Expanded(
                  child: Center(
                    child: Text(
                      w,
                      style: TextStyle(
                        color: c,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final maxHeight = constraints.maxHeight;
                  final maxWidth = constraints.maxWidth;
                  final numRows = ((start + last.day) / 7).ceil().clamp(4, 6);
                  const numCols = 7;

                  final cellHeight = maxHeight / numRows;
                  final cellWidth = maxWidth / numCols;
                  final aspectRatio = cellWidth / cellHeight;

                  return GridView.count(
                    crossAxisCount: numCols,
                    childAspectRatio: aspectRatio,
                    physics: const NeverScrollableScrollPhysics(),
                    children: days,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
