import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'scaffold_with_nav_bar.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/discover/screens/discover_screen.dart';
import '../../features/discover/screens/merchant_detail_screen.dart';
import '../../features/discover/screens/tomb_detail_screen.dart';
import '../../features/guide/screens/funeral_guide_screen.dart';
import '../../features/guide/screens/guide_step_detail_screen.dart';
import '../../features/memorial/screens/memorial_screen.dart';
import '../../features/memorial/screens/family_tree_screen.dart';
import '../../features/memorial/screens/guestbook_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/profile/screens/orders_screen.dart';
import '../../features/profile/screens/contracts_screen.dart';
import '../../features/merchant/screens/merchant_analytics_screen.dart';
import '../../features/merchant/screens/merchant_dashboard_screen.dart';
import '../../features/merchant/screens/merchant_orders_screen.dart';
import '../../features/merchant/screens/merchant_reviews_screen.dart';
import '../../features/cemetery/screens/cemetery_dashboard_screen.dart';
import '../../features/cemetery/screens/cemetery_inventory_screen.dart';
import '../../features/cemetery/screens/cemetery_map_screen.dart';
import '../../features/profile/screens/funeral_plan_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(child: child),
      routes: [
        GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
        GoRoute(path: '/discover', builder: (context, state) => const DiscoverScreen()),
        GoRoute(
          path: '/discover/merchant/:id',
          builder: (context, state) => MerchantDetailScreen(merchantId: state.pathParameters['id']!),
        ),
        GoRoute(
          path: '/discover/tomb/:id',
          builder: (context, state) => TombDetailScreen(tombId: state.pathParameters['id']!),
        ),
        GoRoute(path: '/guide', builder: (context, state) => const FuneralGuideScreen()),
        GoRoute(
          path: '/guide/step/:index',
          builder: (context, state) => GuideStepDetailScreen(stepIndex: int.parse(state.pathParameters['index']!)),
        ),
        GoRoute(path: '/memorial', builder: (context, state) => const MemorialScreen()),
        GoRoute(path: '/memorial/tree', builder: (context, state) => const FamilyTreeScreen()),
        GoRoute(path: '/memorial/guestbook', builder: (context, state) => const GuestbookScreen()),
        GoRoute(path: '/profile', builder: (context, state) => const ProfileScreen()),
        GoRoute(path: '/profile/orders', builder: (context, state) => const OrdersScreen()),
        GoRoute(path: '/profile/contracts', builder: (context, state) => const ContractsScreen()),
        GoRoute(path: '/profile/funeral-plan', builder: (context, state) => const FuneralPlanScreen()),
      ],
    ),
    GoRoute(path: '/merchant/dashboard', builder: (context, state) => const MerchantDashboardScreen()),
    GoRoute(path: '/merchant/orders', builder: (context, state) => const MerchantOrdersScreen()),
    GoRoute(path: '/merchant/reviews', builder: (context, state) => const MerchantReviewsScreen()),
    GoRoute(path: '/merchant/analytics', builder: (context, state) => const MerchantAnalyticsScreen()),
    GoRoute(path: '/cemetery/dashboard', builder: (context, state) => const CemeteryDashboardScreen()),
    GoRoute(path: '/cemetery/inventory', builder: (context, state) => const CemeteryInventoryScreen()),
    GoRoute(path: '/cemetery/map', builder: (context, state) => const CemeteryMapScreen()),
  ],
);
