import 'package:assignment2/app/main_shell.dart';
import 'package:assignment2/features/navigation/presentation/cubit/navigation_cubit.dart';
import 'package:assignment2/injection_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    if (kDebugMode) debugPrint(details.toString());
  };
  try {
    Injector.init();
    runApp(const AppRoot());
  } catch (e, stack) {
    if (kDebugMode) {
      debugPrint('Startup error: $e');
      debugPrint(stack.toString());
    }
    rethrow;
  }
}

/// Root: Bloc providers + [GetMaterialApp].
class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NavigationCubit()),
        BlocProvider(create: (_) => Injector.createFavoritesCubit()),
        BlocProvider(create: (_) => Injector.createMessagesCubit()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MainShell(),
    );
  }
}
