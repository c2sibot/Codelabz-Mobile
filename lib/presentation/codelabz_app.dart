import 'package:codelabz/presentation/routes/routes.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CodeLabzApp extends StatelessWidget {
  static late FluroRouter _router;
  static FluroRouter get router => _router;

  CodeLabzApp() {
    final router = FluroRouter();
    Routes.configureRouter(router);
    _router = router;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [],
      child: MaterialApp(
        title: "CodeLabz",
        onGenerateRoute: router.generator,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
