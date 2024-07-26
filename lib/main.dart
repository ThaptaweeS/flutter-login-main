import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'bloc/Observe/appBlocObserver.dart';
import 'bloc/cubit/Rebuild.dart';
import 'constants.dart';
import 'mainBody.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
);

Future<void> main() async {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BlocPageRebuild>(
          create: (BuildContext context) =>
              BlocPageRebuild(), // For rebuild only page inside without app bar/left menu
        ),
      ],
      child: const MainContext(),
    );
  }
}

class MainContext extends StatefulWidget {
  const MainContext({Key? key}) : super(key: key);

  @override
  _MainContextState createState() => _MainContextState();
}

class _MainContextState extends State<MainContext> {
  bool isDarkMode = false;
  bool isLightMode = true;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void toggleLightMode() {
    setState(() {
      isLightMode = !isLightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlocPageRebuild, bool>(
      builder: (_, e) {
        return MaterialApp(
          title: 'Web Application',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: bgColor,
            textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.white),
            canvasColor: secondaryColor,
          ),
          home: const MainBlocRebuild(),
        );
      },
    );
  }
}
