import 'package:coloors/logic/cubit/library_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubit/generator_cubit.dart';
import 'logic/cubit/settings_cubit.dart';
import 'views/pages/generator.dart';

final _log = Logger('main.dart');
void main() async {
  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  }
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name} : ${record.time} : '
        '${record.loggerName} : '
        '${record.message}');
  });

  // changeColorOfStatusBar(Colors.transparent);

  _log.info('Initializing HydratedStorage');
  WidgetsFlutterBinding.ensureInitialized();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(const MyApp()),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => GeneratorCubit(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LibraryCubit(),
          lazy: false,
        ),
      ],
      child: const MaterialApp(
        title: 'Coloous',
        home: GeneratorPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
