import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'feature/posts/view/posts_page_bloc.dart';
import 'feature/posts/view/posts_page_provider.dart';
import 'feature/posts/view/posts_page_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST API Example',
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      home: const _Home(),
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();

  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const PostsPageBloc(),
      const PostsPageProvider(),
      const PostsPageRiverpod(),
    ];
    return Scaffold(
      body: pages[_index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.data_object), label: 'Bloc'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Provider'),
          NavigationDestination(
              icon: Icon(Icons.donut_small), label: 'Riverpod'),
        ],
        onDestinationSelected: (i) => setState(() => _index = i),
      ),
    );
  }
}
