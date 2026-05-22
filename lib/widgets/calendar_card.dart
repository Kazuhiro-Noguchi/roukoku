import 'package:flutter/material.dart';
import 'drum_wheel.dart';

class CalendarCard extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final Function(DateTime) onDateSelected;

  const CalendarCard({
    super.key,
    required this.selectedDate,
    required this.onPreviousMonth,
    required this.onNextMonth,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final year = selectedDate.year;
    final month = selectedDate.month;

    final first = DateTime(year, month, 1);
    final last = DateTime(year, month + 1, 0);

    final start = first.weekday % 7; // Sunday=0

    final days = <Widget>[];
    for (int i = 0; i < start; i++) {
      days.add(const SizedBox());
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final dateFontSize = (screenWidth / 187).clamp(18.0, 30.0);
    final dateLargeFontSize = (screenWidth / 153).clamp(21.0, 36.0);

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
                  ? BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    )
                  : null,
              child: Text(
                "$d",
                style: TextStyle(
                  color: isToday ? Colors.white : textColor,
                  fontSize: isToday ? dateLargeFontSize : dateFontSize,
                  fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      );
    }

    final weekdays = ['日', '月', '火', '水', '木', '金', '土'];

    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxWidth = constraints.maxWidth;
            final headerFontSize = (maxWidth / 150).clamp(20.0, 40.0);
            final weekdayFontSize = (maxWidth / 160).clamp(21.0, 33.0);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: onPreviousMonth,
                    ),
                    GestureDetector(
                      onTap: () => _showYearMonthPicker(context, year, month),
                      child: Text(
                        '$year年 $month月',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: headerFontSize,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: onNextMonth,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: weekdays.map((w) {
                    Color c = Theme.of(context).colorScheme.onSurface;
                    if (w == '日') c = Colors.redAccent;
                    if (w == '土') c = Colors.blueAccent;
                    return Expanded(
                      child: Center(
                        child: Text(
                          w,
                          style: TextStyle(
                            color: c,
                            fontWeight: FontWeight.bold,
                            fontSize: weekdayFontSize,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 4),
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxHeight = constraints.maxHeight;
                      final maxWidth = constraints.maxWidth;
                      const numRows = 6;
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
            );
          },
        ),
      ),
    );
  }

  void _showYearMonthPicker(
    BuildContext context,
    int currentYear,
    int currentMonth,
  ) {
    const minYear = 1980;
    const maxYear = 2100;
    int selectedYear = currentYear.clamp(minYear, maxYear);
    int selectedMonth = currentMonth;

    final yearController = FixedExtentScrollController(
      initialItem: selectedYear - minYear,
    );
    final monthController = FixedExtentScrollController(
      initialItem: selectedMonth - 1,
    );
    final cs = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.72),
      builder: (BuildContext context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) => Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 28,
          ),
          child: Container(
            width: 348,
            height: 312,
            decoration: BoxDecoration(
              color: cs.surfaceContainerHighest.withValues(alpha: 0.96),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(
                color: cs.primary.withValues(alpha: 0.28),
                width: 1.2,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 30,
                  offset: Offset(0, 18),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(28),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          cs.primary.withValues(alpha: 0.28),
                          cs.primaryContainer.withValues(alpha: 0.18),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '年月を選択',
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: cs.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$selectedYear年 $selectedMonth月',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: cs.primary,
                                fontWeight: FontWeight.w700,
                                fontFeatures: const [
                                  FontFeature.tabularFigures(),
                                ],
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned.fill(
                          child: Row(
                            children: [
                              Expanded(
                                child: DrumWheel(
                                  controller: yearController,
                                  itemExtent: 40,
                                  selectedIndex: selectedYear - minYear,
                                  selectedColor: cs.primary,
                                  unselectedColor: cs.onSurface.withValues(
                                    alpha: 0.62,
                                  ),
                                  selectedBackground: cs.primary.withValues(
                                    alpha: 0.22,
                                  ),
                                  itemBuilder: (index, isSelected) => Text(
                                    '${minYear + index}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1,
                                      color: isSelected
                                          ? cs.primary
                                          : cs.onSurface.withValues(
                                              alpha: 0.72,
                                            ),
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  onSelectedItemChanged: (index) => setState(
                                    () => selectedYear = minYear + index,
                                  ),
                                  itemCount: maxYear - minYear + 1,
                                ),
                              ),
                              SizedBox(
                                width: 28,
                                child: Center(
                                  child: Text(
                                    '年',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: cs.onSurface.withValues(
                                            alpha: 0.75,
                                          ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: DrumWheel(
                                  controller: monthController,
                                  itemExtent: 40,
                                  selectedIndex: selectedMonth - 1,
                                  selectedColor: cs.primary,
                                  unselectedColor: cs.onSurface.withValues(
                                    alpha: 0.62,
                                  ),
                                  selectedBackground: cs.primary.withValues(
                                    alpha: 0.22,
                                  ),
                                  itemBuilder: (index, isSelected) => Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      height: 1,
                                      color: isSelected
                                          ? cs.primary
                                          : cs.onSurface.withValues(
                                              alpha: 0.72,
                                            ),
                                      fontWeight: isSelected
                                          ? FontWeight.w700
                                          : FontWeight.w400,
                                    ),
                                  ),
                                  onSelectedItemChanged: (index) =>
                                      setState(() => selectedMonth = index + 1),
                                  itemCount: 12,
                                ),
                              ),
                              SizedBox(
                                width: 28,
                                child: Center(
                                  child: Text(
                                    '月',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          color: cs.onSurface.withValues(
                                            alpha: 0.75,
                                          ),
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            foregroundColor: cs.onSurface.withValues(
                              alpha: 0.78,
                            ),
                          ),
                          child: const Text('キャンセル'),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            final now = DateTime.now();
                            final targetYearIndex = (now.year - minYear).clamp(
                              0,
                              maxYear - minYear,
                            );
                            final targetMonthIndex = (now.month - 1).clamp(
                              0,
                              11,
                            );
                            yearController.animateToItem(
                              targetYearIndex,
                              duration: const Duration(milliseconds: 420),
                              curve: Curves.easeOut,
                            );
                            monthController.animateToItem(
                              targetMonthIndex,
                              duration: const Duration(milliseconds: 420),
                              curve: Curves.easeOut,
                            );
                            setState(() {
                              selectedYear = now.year.clamp(minYear, maxYear);
                              selectedMonth = now.month;
                            });
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: cs.primary,
                          ),
                          child: const Text('今月'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () {
                            onDateSelected(
                              DateTime(selectedYear, selectedMonth, 1),
                            );
                            Navigator.pop(context);
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: cs.primary,
                            foregroundColor: cs.onPrimary,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                          ),
                          child: const Text('決定'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
