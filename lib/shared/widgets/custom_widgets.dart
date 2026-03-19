import 'package:flutter/material.dart';

// --- Theme & shared styles ---
const Color kPrimaryColor = Color(0xFF5A5A9A);
const Color kLightGrayColor = Color(0xFFCCCCCC);
const TextStyle kWhiteTextStyle = TextStyle(color: Colors.white);
const TextStyle kLightGrayTextStyle = TextStyle(color: kLightGrayColor);

/// Top search bar used on the home screen.
class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.menu, color: Colors.white),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E2E),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.search, color: kLightGrayColor, size: 20),
                SizedBox(width: 10),
                Expanded(child: Text('Where to?', style: kLightGrayTextStyle)),
                Icon(Icons.mic, color: kLightGrayColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Bottom bar colors (Figma-style dark navy + muted icons)
const Color _kBottomBarBg = Color(0xFF12182B);
const Color _kBottomIconMuted = Color(0xFF8B9BB4);

/// Custom bottom bar: rounded top corners, navy background, 4 icons.
/// First tab shows a glowing ring when selected; others use muted icons when inactive.
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: _kBottomBarBg,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(8, 14, 8, 14 + bottomInset),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: _NavItemHome(selected: currentIndex == 0, onTap: () => onTap(0))),
            Expanded(child: _NavItemIcon(icon: Icons.airplanemode_active, selected: currentIndex == 1, onTap: () => onTap(1))),
            Expanded(child: _NavItemIcon(icon: Icons.favorite, selected: currentIndex == 2, onTap: () => onTap(2))),
            Expanded(child: _NavItemIcon(icon: Icons.chat_bubble_outline, selected: currentIndex == 3, onTap: () => onTap(3))),
          ],
        ),
      ),
    );
  }
}

/// First tab: same white/muted style as other icons when selected/unselected.
class _NavItemHome extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;

  const _NavItemHome({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : _kBottomIconMuted;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Icon(Icons.circle_outlined, color: color, size: 26),
      ),
    );
  }
}

class _NavItemIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _NavItemIcon({
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = selected ? Colors.white : _kBottomIconMuted;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: Icon(icon, color: color, size: 26),
      ),
    );
  }
}

/// Listing card for the home screen.
class CustomCard extends StatelessWidget {
  final String title;
  final double cost;
  final double distance;
  final String availableDates;
  final String imageUrl;

  const CustomCard({
    super.key,
    required this.title,
    required this.cost,
    required this.distance,
    required this.availableDates,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.8),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E2E).withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: kPrimaryColor, width: 1.5),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16),
                            SizedBox(width: 5),
                            Text('4.1 (1,648)', style: TextStyle(color: Colors.white, fontSize: 14)),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.favorite_border, color: Colors.white, size: 28),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: kWhiteTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.white12, width: 1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInfoItem(icon: Icons.attach_money, label: '$cost CAD / night', isCost: true),
                        _buildInfoItem(icon: Icons.directions_run, label: '$distance km'),
                        _buildInfoItem(icon: Icons.calendar_today, label: availableDates),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    bool isCost = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isCost ? 'COST' : (icon == Icons.directions_run ? 'DISTANCE' : 'AVAILABLE'),
          style: const TextStyle(color: kLightGrayColor, fontSize: 10, letterSpacing: 1.5),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Icon(icon, color: Colors.white, size: 18),
            const SizedBox(width: 5),
            Text(label, style: kWhiteTextStyle.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }
}
