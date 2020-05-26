import 'package:example/str/en_s.dart';
import 'package:example/str/s.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        LocaleDelegate(),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class LocaleDelegate extends LocalizationsDelegate<S> {
  final supportLocale = ["en"];

  @override
  bool isSupported(Locale locale) {
    return supportLocale.contains(locale.languageCode);
  }

  @override
  Future<S> load(Locale locale) async {
    return EnS();
  }

  @override
  bool shouldReload(LocalizationsDelegate<S> old) {
    return false;
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = Localizations.of<S>(context, S);
    return Text(s.get(S.text));
  }
}
