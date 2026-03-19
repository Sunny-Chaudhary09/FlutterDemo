import 'dart:ui';

import 'package:flutter/material.dart';

/// Details page (second tab): hero image, glassmorphism card, host info, Book Now.
class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  static const String _heroImage = 'assets/image1.jpeg';
  static const double _imageHeight = 320;

  @override
  Widget build(BuildContext context) {
    // No nested Scaffold — it breaks layout inside IndexedStack / tabs.
    return ColoredBox(
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1. Full-width background image (top)
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: _imageHeight,
            child: Image.asset(
              _heroImage,
              fit: BoxFit.cover,
            ),
          ),
          // Gradient overlay so back button and dots are visible
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: _imageHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.5),
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // 2. Top bar: Back, heart, share
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.chevron_left, color: Colors.white, size: 28),
                        SizedBox(width: 4),
                        Text('Back', style: TextStyle(color: Colors.white, fontSize: 17)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.favorite_border, color: Colors.white), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.share, color: Colors.white), onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // 3. Page indicator dots (center-bottom of image)
          Positioned(
            left: 0,
            right: 0,
            bottom: _imageHeight - 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _dot(selected: true),
                const SizedBox(width: 8),
                _dot(selected: false),
                const SizedBox(width: 8),
                _dot(selected: false),
              ],
            ),
          ),
          // 4. Scrollable content: glass card + superhost card
          ListView(
            padding: EdgeInsets.only(top: _imageHeight - 24),
            children: [
              _GlassCard(),
              const SizedBox(height: 12),
              _SuperhostCard(),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dot({required bool selected}) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected ? Colors.white : Colors.white.withOpacity(0.4),
      ),
    );
  }
}

/// Main info card with glassmorphism (blur + dark tint).
class _GlassCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white.withOpacity(0.15), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HostRow(),
                const SizedBox(height: 16),
                const Text(
                  'Luxury, Lifestyle',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                _StatsRow(),
                const SizedBox(height: 14),
                _LocationRow(),
                const SizedBox(height: 20),
                _BookNowButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HostRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: const Color(0xFF2A2A3E),
              child: Icon(Icons.person, color: Colors.white70, size: 32),
            ),
            Positioned(
              right: -4,
              bottom: -4,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: const Color(0xFFE91E8C),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: const Icon(Icons.shield, color: Colors.white, size: 12),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        const Text(
          'Hosted by Trang',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Colors.white, size: 20),
        const SizedBox(width: 6),
        const Text('4.9', style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
        _verticalDivider(),
        const Text('1,648 reviews', style: TextStyle(color: Colors.white70, fontSize: 14)),
        _verticalDivider(),
        const Icon(Icons.shield_outlined, color: Colors.white70, size: 18),
        const SizedBox(width: 4),
        const Text('Superhost', style: TextStyle(color: Colors.white70, fontSize: 14)),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 14,
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.white38,
    );
  }
}

class _LocationRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: const BoxDecoration(
            color: Color(0xFF2563EB),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.location_on, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            '1155 Rue Sherbrooke Ouest, Toronto, Canada H3A 2N3',
            style: TextStyle(color: Colors.white70, fontSize: 13),
          ),
        ),
      ],
    );
  }
}

class _BookNowButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            colors: [Color(0xFF4C5FD5), Color(0xFF3B4BB5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C5FD5).withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),
            child: const Center(
              child: Text(
                'Book Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom “Trang is a Superhost” card.
class _SuperhostCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E2E),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.shield, color: Color(0xFF60A5FA), size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trang is a Superhost',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Superhosts are experienced, highly rated hosts committed to providing great stays.',
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
