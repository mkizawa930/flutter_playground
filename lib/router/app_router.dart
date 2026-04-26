import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../pages/home_page.dart';
import '../pages/user_page.dart';
import '../widgets/my_bottom_navigation.dart';

class _TabDef {
  const _TabDef({
    required this.path,
    required this.icon,
    required this.label,
    required this.page,
  });
  final String path;
  final IconData icon;
  final String label;
  final Widget page;
}

const _tabs = <_TabDef>[
  _TabDef(path: '/home', icon: Icons.home, label: 'Home', page: HomePage()),
  _TabDef(path: '/user', icon: Icons.person, label: 'User', page: UserPage()),
];

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: _tabs.first.path,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => _ScaffoldWithNav(child: child),
      routes: [
        for (final tab in _tabs)
          GoRoute(
            path: tab.path,
            pageBuilder: (context, state) =>
                NoTransitionPage(child: tab.page),
          ),
      ],
    ),
  ],
);

class _ScaffoldWithNav extends StatelessWidget {
  const _ScaffoldWithNav({required this.child});
  final Widget child;

  int _indexFor(String location) {
    final i = _tabs.indexWhere((t) => location.startsWith(t.path));
    return i < 0 ? 0 : i;
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: child,
      bottomNavigationBar: MyBottomNavigation(
        items: [
          for (final tab in _tabs)
            MyBottomNavItem(icon: tab.icon, label: tab.label),
        ],
        currentIndex: _indexFor(location),
        onTap: (i) => context.go(_tabs[i].path),
      ),
    );
  }
}
