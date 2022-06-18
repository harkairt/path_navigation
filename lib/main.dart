import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

DateTime lastMainRun = DateTime.now();

void main() {
  lastMainRun = DateTime.now();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late GoRouter router;

  @override
  void initState() {
    router = GoRouter(
      initialLocation: '/auth/login',
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          redirect: (state) => "/auth",
        ),
        GoRoute(
          path: '/auth',
          builder: (context, state) => const Page(title: '/auth'),
          routes: [
            GoRoute(
              path: 'login',
              builder: (context, state) => const Page(title: '/auth/login'),
            ),
          ],
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const Page(title: '/contact'),
        ),
      ],
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
    );
  }
}

class Page extends StatelessWidget {
  const Page({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            Text(lastMainRun.toString()),
          ],
        ),
      ),
    );
  }
}
