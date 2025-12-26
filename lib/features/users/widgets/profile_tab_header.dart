import 'package:flutter/material.dart';

class ProfileTabHeader extends SliverPersistentHeaderDelegate {
  final String selectedTab;
  final bool isDark;
  final Function(String) onTabChanged;

  ProfileTabHeader({
    required this.selectedTab,
    required this.isDark,
    required this.onTabChanged,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: isDark ? Colors.black : Colors.white,
      child: Column(
        children: [
          Container(
            height: 1,
            color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged('Threads'),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == 'Threads'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Threads',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'Threads'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => onTabChanged('Replies'),
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: selectedTab == 'Replies'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Replies',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: selectedTab == 'Replies'
                              ? (isDark ? Colors.white : Colors.black)
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 49;

  @override
  double get minExtent => 49;

  @override
  bool shouldRebuild(covariant ProfileTabHeader oldDelegate) {
    return selectedTab != oldDelegate.selectedTab ||
        isDark != oldDelegate.isDark;
  }
}
