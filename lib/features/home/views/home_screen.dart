import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const path = '/';

  static GoRoute route({
    List<RouteBase> routes = const [],
    GlobalKey<NavigatorState>? parentNavigatorKey,
  }) =>
      GoRoute(
        parentNavigatorKey: parentNavigatorKey,
        path: HomeScreen.path,
        name: HomeScreen.path,
        builder: (context, state) {
          return BlocProvider<HomeBloc>(
            create: (context) => HomeBloc()..add(const HomeInit()),
            child: const HomePage(),
          );
        },
        routes: routes,
      );

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}
