import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_challenge/features/settings/view_models/dark_mode_view_model.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeProvider);

    return SliverAppBar(
      backgroundColor: isDark ? Colors.black : Colors.white,
      surfaceTintColor: isDark ? Colors.black : Colors.white,
      elevation: 0,
      floating: false,
      pinned: true,
      expandedHeight: 80,
      collapsedHeight: 56,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          // Calculate icon size based on available height
          const double maxHeight = 80;
          const double minHeight = 56;
          final double currentHeight = constraints.maxHeight;

          // Interpolate icon size between 32 (expanded) and 24 (collapsed)
          final double iconSize = 24 +
              (8 * ((currentHeight - minHeight) / (maxHeight - minHeight)));

          // Position icon at top when collapsed
          final double topPadding = currentHeight < maxHeight ? 16 : 24;

          return Container(
            color: isDark ? Colors.black : Colors.white,
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(top: topPadding),
            child: FaIcon(
              FontAwesomeIcons.at,
              color: isDark ? Colors.white : Colors.black,
              size: iconSize.clamp(24, 32),
            ),
          );
        },
      ),
    );
  }
}
