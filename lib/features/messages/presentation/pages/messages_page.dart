import 'dart:math' as math;
import 'dart:ui';

import 'package:assignment2/features/messages/domain/entities/user_ui_settings.dart';
import 'package:assignment2/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Settings / slide-out menu style screen (Messages tab).
class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const _headerMuted = Color(0xFF7A8BA8);
  static const _rowText = Colors.white;
  static const _glowBlue = Color(0xFF3B7CFF);
  static const _panelBg = Color(0xCC0D1528);

  @override
  Widget build(BuildContext context) {
    final topPad = MediaQuery.paddingOf(context).top;
    final bottomPad = MediaQuery.paddingOf(context).bottom;

    return ColoredBox(
      color: const Color(0xFF080C16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0D1528),
                    Color(0xFF151032),
                    Color(0xFF0A0E1A),
                  ],
                  stops: [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            right: -80,
            top: 120,
            child: IgnorePointer(
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF2D4A9E).withOpacity(0.25),
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 22,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _panelBg,
                        border: Border(
                          right: BorderSide(color: Colors.white.withOpacity(0.06)),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: topPad + 8),
                          _buildHeader(context),
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.fromLTRB(20, 8, 16, bottomPad + 24),
                              children: [
                                _sectionTitle('Account Setting'),
                                _menuRow(
                                  icon: Icons.notifications_outlined,
                                  label: 'Notifications',
                                  trailing: _badge(12),
                                ),
                                _menuRow(
                                  icon: Icons.credit_card,
                                  label: 'Payment',
                                  highlighted: true,
                                ),
                                _menuRow(
                                  icon: Icons.translate,
                                  label: 'Translate',
                                ),
                                _menuRow(
                                  icon: Icons.verified_user_outlined,
                                  label: 'Privacy',
                                ),
                                const SizedBox(height: 20),
                                _sectionTitle('Hosting'),
                                _menuRow(
                                  icon: Icons.smartphone_outlined,
                                  label: 'Listing',
                                ),
                                _menuRow(
                                  icon: Icons.record_voice_over_outlined,
                                  label: 'Host',
                                ),
                                const SizedBox(height: 20),
                                _sectionTitle('More'),
                                _darkModeRow(context),
                                _menuRow(
                                  icon: Icons.update,
                                  label: 'Update',
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
              Expanded(
                flex: 9,
                child: _BackgroundPeek(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 12, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white.withOpacity(0.12),
            child: const Icon(Icons.person, color: Colors.white, size: 32),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Alice Portman',
                  style: TextStyle(
                    color: _rowText,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    foregroundColor: _headerMuted,
                  ),
                  child: const Text(
                    'Show Profile',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.maybePop(context);
            },
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
                border: Border.all(color: Colors.white12),
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        text,
        style: const TextStyle(
          color: _headerMuted,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _badge(int count) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _glowBlue,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _glowBlue.withOpacity(0.45),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _menuRow({
    required IconData icon,
    required String label,
    Widget? trailing,
    bool highlighted = false,
  }) {
    final showGlow = highlighted;

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(14),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: showGlow ? const Color(0xFF1A3A6E).withOpacity(0.55) : Colors.transparent,
              boxShadow: showGlow
                  ? [
                      BoxShadow(
                        color: _glowBlue.withOpacity(0.35),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: _glowBlue.withOpacity(0.15),
                        blurRadius: 28,
                        spreadRadius: 2,
                      ),
                    ]
                  : null,
              border: showGlow
                  ? Border.all(color: _glowBlue.withOpacity(0.45), width: 1)
                  : null,
            ),
            child: Row(
              children: [
                _DiamondIcon(icon: icon),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: _rowText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (trailing != null) trailing else const Icon(Icons.chevron_right, color: Colors.white54, size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _darkModeRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: BlocBuilder<MessagesCubit, UserUiSettings>(
        buildWhen: (prev, curr) => prev.darkModeEnabled != curr.darkModeEnabled,
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                _DiamondIcon(icon: Icons.dark_mode_outlined),
                const SizedBox(width: 14),
                const Expanded(
                  child: Text(
                    'Dark Mode',
                    style: TextStyle(
                      color: _rowText,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Switch.adaptive(
                  value: state.darkModeEnabled,
                  onChanged: (v) => context.read<MessagesCubit>().setDarkModeEnabled(v),
                  activeThumbColor: Colors.white,
                  activeTrackColor: _glowBlue,
                  inactiveThumbColor: Colors.white54,
                  inactiveTrackColor: Colors.white24,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Rounded diamond frame with counter-rotated icon.
class _DiamondIcon extends StatelessWidget {
  final IconData icon;

  const _DiamondIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    const size = 44.0;
    return SizedBox(
      width: size,
      height: size,
      child: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1A2744),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.35),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Icon(icon, color: Colors.white, size: 21),
          ),
        ),
      ),
    );
  }
}

/// Dimmed strip suggesting content behind the menu.
class _BackgroundPeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black.withOpacity(0.35),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: -40,
            top: 100,
            right: -20,
            child: Opacity(
              opacity: 0.45,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 36,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 28,
                    width: 80,
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A3F6E).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Cabins',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2A45),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 72,
                          decoration: BoxDecoration(
                            color: Colors.white12,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Toronto, ON',
                          style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$280 CAD | night',
                          style: TextStyle(color: Colors.white.withOpacity(0.45), fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
