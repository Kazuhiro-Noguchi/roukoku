import 'dart:async';
import 'package:flutter/material.dart';

import 'widgets/clock_card.dart';
import 'widgets/analog_clock.dart';
import 'widgets/calendar_card.dart';
import 'widgets/mini_calendar_card.dart';

void main() {
  runApp(const MyApp());
}

const seedColor = Color(0xFF2980AF);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: seedColor,
        brightness: Brightness.dark,
        fontFamily: 'NotoSansJP',
      ),
      home: const DashboardPage(),
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DateTime selectedDate;
  late DateTime currentTime;
  Timer? clockTimer;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentTime = DateTime.now();
    _scheduleNextTick();
  }

  void _scheduleNextTick() {
    final now = DateTime.now();
    final delay = Duration(milliseconds: 1000 - now.millisecond);
    clockTimer = Timer(delay, () {
      if (!mounted) return;
      setState(() => currentTime = DateTime.now());
      _scheduleNextTick();
    });
  }

  void _previousMonth() => setState(() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month - 1);
  });

  void _nextMonth() => setState(() {
    selectedDate = DateTime(selectedDate.year, selectedDate.month + 1);
  });

  void _selectDate(DateTime newDate) => setState(() {
    selectedDate = newDate;
  });

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLandscape = constraints.maxWidth > constraints.maxHeight;

            if (isLandscape) {
              return Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        Expanded(flex: 3, child: ClockCard(now: currentTime)),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 2,
                          child: Center(child: AnalogClock(now: currentTime)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: CalendarCard(
                            selectedDate: selectedDate,
                            onPreviousMonth: _previousMonth,
                            onNextMonth: _nextMonth,
                            onDateSelected: _selectDate,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Expanded(
                                child: MiniCalendarCard(
                                  monthOffset: -1,
                                  baseDate: selectedDate,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: MiniCalendarCard(
                                  monthOffset: 1,
                                  baseDate: selectedDate,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            // portrait fallback
            return Column(
              children: [
                Expanded(flex: 2, child: ClockCard(now: currentTime)),
                const SizedBox(height: 10),
                Expanded(
                  flex: 3,
                  child: CalendarCard(
                    selectedDate: selectedDate,
                    onPreviousMonth: _previousMonth,
                    onNextMonth: _nextMonth,
                    onDateSelected: _selectDate,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
