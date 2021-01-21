import 'package:clean_architecture/Features/presentation/bloc/NumberBloc/number_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:clean_architecture/di/di.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Features/presentation/pages/number_page.dart';
import 'di/di.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(App());
}
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: [
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ],
      home: BlocProvider(
        create: (context) => sl<NumberBloc>() ,
          child: MyScreen()),
    );
  }
}
