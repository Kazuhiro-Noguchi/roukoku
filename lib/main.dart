import 'dart:async';
import 'package:flutter/material.dart';

import 'widgets/clock_card.dart';
import 'widgets/analog_clock.dart';
import 'widgets/calendar_card.dart';
import 'widgets/mini_calendar_card.dart';
import 'services/fullscreen_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  final FullscreenService fullscreenService = createFullscreenService();
  late DateTime selectedDate;
  late DateTime currentTime;
  bool isFullscreen = false;
  Timer? clockTimer;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    currentTime = DateTime.now();
    unawaited(fullscreenService.initialize());
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

  Future<void> _toggleFullscreen() async {
    final nextValue = !isFullscreen;
    final actualValue = await fullscreenService.setFullscreen(nextValue);

    if (!mounted) return;

    setState(() {
      isFullscreen = actualValue;
    });
  }

  @override
  void dispose() {
    clockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Padding(
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
          Positioned(
            top: 12,
            left: 12,
            child: SafeArea(
              child: Material(
                color: cs.surfaceContainerHighest.withValues(alpha: 0.9),
                elevation: 4,
                shape: const StadiumBorder(),
                child: IconButton(
                  tooltip: isFullscreen ? '全画面を終了' : '全画面にする',
                  icon: Icon(
                    isFullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
                  ),
                  onPressed: _toggleFullscreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
