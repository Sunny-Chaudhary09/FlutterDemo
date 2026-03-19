import 'dart:ui';

import 'package:assignment2/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

/// Date selection / booking screen (Favorites tab).
/// State: [FavoritesCubit] (Bloc). Snackbar: GetX example on "Next".
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  static const _weekdayLabels = ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT'];

  static int _sundayFirstColumn(DateTime date) =>
      date.weekday == DateTime.sunday ? 0 : date.weekday;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        return ColoredBox(
          color: const Color(0xFF0A0E18),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 180,
                left: 0,
                right: 0,
                height: 320,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: Alignment.center,
                      radius: 0.85,
                      colors: [
                        const Color(0xFF2D4A8C).withOpacity(0.45),
                        const Color(0xFF1A2744).withOpacity(0.15),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.45, 1.0],
                    ),
                  ),
                ),
              ),
              SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildHeader(context),
                    const SizedBox(height: 8),
                    _buildStaySummary(state),
                    const SizedBox(height: 20),
                    _buildWeekdayRow(),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: _buildGlassCalendar(context, state),
                    ),
                    const SizedBox(height: 16),
                    _buildMonthArrows(context),
                    const Spacer(),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: _buildBottomBar(context, state),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            onPressed: () => Navigator.maybePop(context),
            icon: const Icon(Icons.chevron_left, color: Colors.white, size: 28),
            label: const Text('Back', style: TextStyle(color: Colors.white, fontSize: 17)),
            style: TextButton.styleFrom(foregroundColor: Colors.white),
          ),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Cancel date',
              style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaySummary(FavoritesState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.stayTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            state.staySubtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.55),
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: _weekdayLabels
            .map(
              (d) => Text(
                d,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildGlassCalendar(BuildContext context, FavoritesState state) {
    final first = DateTime(state.focusedMonth.year, state.focusedMonth.month);
    final daysInMonth =
        DateTime(state.focusedMonth.year, state.focusedMonth.month + 1, 0).day;
    final leading = _sundayFirstColumn(first);

    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          child: Column(
            children: [
              Text(
                state.monthYearLabel(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _CalendarGrid(
                leadingBlanks: leading,
                daysInMonth: daysInMonth,
                focusedYear: state.focusedMonth.year,
                focusedMonth: state.focusedMonth.month,
                isInRange: state.isInSelectedRange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMonthArrows(BuildContext context) {
    final cubit = context.read<FavoritesCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _RoundNavButton(icon: Icons.chevron_left, onTap: cubit.previousMonth),
        const SizedBox(width: 20),
        _RoundNavButton(icon: Icons.chevron_right, onTap: cubit.nextMonth),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, FavoritesState state) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(20, 16, 20, 12 + bottomPad),
          decoration: BoxDecoration(
            color: const Color(0xFF12182B).withOpacity(0.92),
            border: Border(top: BorderSide(color: Colors.white.withOpacity(0.06))),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(color: Colors.white, fontSize: 17),
                        children: const [
                          TextSpan(text: '\$200 CAD ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: 'night', style: TextStyle(fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.calendar_today_outlined, size: 14, color: Colors.white.withOpacity(0.7)),
                        const SizedBox(width: 6),
                        Text(
                          state.bottomDateLine,
                          style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                height: 48,
                constraints: const BoxConstraints(minWidth: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF5B8CFF), Color(0xFF3B5FD9)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A7AFF).withOpacity(0.35),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.snackbar(
                        'Dates',
                        '${state.bottomDateLine} · ${state.stayTitle}',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: const Color(0xFF1E2638),
                        colorText: Colors.white,
                        margin: const EdgeInsets.all(16),
                        borderRadius: 12,
                      );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: Text(
                          'Next',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoundNavButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _RoundNavButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF1E2638),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Icon(icon, color: Colors.white70, size: 22),
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final int leadingBlanks;
  final int daysInMonth;
  final int focusedYear;
  final int focusedMonth;
  final bool Function(DateTime day) isInRange;

  const _CalendarGrid({
    required this.leadingBlanks,
    required this.daysInMonth,
    required this.focusedYear,
    required this.focusedMonth,
    required this.isInRange,
  });

  @override
  Widget build(BuildContext context) {
    final cells = <Widget>[];

    for (var i = 0; i < leadingBlanks; i++) {
      cells.add(const SizedBox());
    }
    for (var day = 1; day <= daysInMonth; day++) {
      final date = DateTime(focusedYear, focusedMonth, day);
      final inRange = isInRange(date);
      cells.add(
        Center(
          child: Text(
            '$day',
            style: TextStyle(
              color: inRange ? Colors.white : Colors.white.withOpacity(0.28),
              fontSize: 15,
              fontWeight: inRange ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 14,
      crossAxisSpacing: 4,
      childAspectRatio: 1.1,
      children: cells,
    );
  }
}
