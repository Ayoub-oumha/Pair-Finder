import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Match the Pair',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
          headlineSmall: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          bodyLarge: TextStyle(height: 1.4),
        ),
      ),
      home: const MatchGamePage(),
    );
  }
}

class MatchGamePage extends StatefulWidget {
  const MatchGamePage({super.key});

  @override
  State<MatchGamePage> createState() => _MatchGamePageState();
}

class _MatchGamePageState extends State<MatchGamePage> {
  final Random _random = Random();

  int rightImage = 1;
  int leftImage = 1;
  int score = 0;
  int streak = 0;
  int rounds = 0;
  String feedback = 'Tap the cards to shuffle and find a match.';

  void _shuffleCards() {
    setState(() {
      rightImage = _random.nextInt(8) + 1;
      leftImage = _random.nextInt(8) + 1;
      rounds += 1;

      if (rightImage == leftImage) {
        score += 1;
        streak += 1;
        feedback = 'Match found. Nice work.';
      } else {
        streak = 0;
        feedback = 'No match yet. Try again.';
      }
    });
  }

  Widget _buildStatCard(String label, String value, Color accent) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 6),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accent.withValues(alpha: 0.2)),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.12),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: accent,
                    fontSize: 28,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF475569),
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(String assetName, Color accent) {
    return Expanded(
      child: GestureDetector(
        onTap: _shuffleCards,
        child: Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white.withValues(alpha: 0.96),
                accent.withValues(alpha: 0.12),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: accent.withValues(alpha: 0.25), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 24,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                assetName,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isMatch = rightImage == leftImage;
    final Color accentColor = isMatch ? const Color(0xFF16A34A) : const Color(0xFF0F766E);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Color(0xFFD9F99D), Color(0xFFBAE6FD)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F766E),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Match the Pair',
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                  color: const Color(0xFF0F172A),
                                  fontSize: 28,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'A simple and polished image matching game.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: const Color(0xFF475569),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    _buildStatCard('Score', score.toString(), const Color(0xFF0F766E)),
                    _buildStatCard('Streak', streak.toString(), const Color(0xFF16A34A)),
                    _buildStatCard('Rounds', rounds.toString(), const Color(0xFFF97316)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.88),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: accentColor.withValues(alpha: 0.16)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        isMatch ? 'Perfect Match' : 'Keep Searching',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: accentColor,
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        feedback,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: const Color(0xFF334155),
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      _buildCard('images/image-$rightImage.png', const Color(0xFF0F766E)),
                      _buildCard('images/image-$leftImage.png', const Color(0xFFF97316)),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _shuffleCards,
                    icon: const Icon(Icons.shuffle),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text(
                        'Shuffle Cards',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F766E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      elevation: 10,
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