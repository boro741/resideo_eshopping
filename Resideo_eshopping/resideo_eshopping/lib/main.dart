import 'package:flutter/material.dart';
import 'package:resideo_eshopping/controller/root_page.dart';
import 'package:resideo_eshopping/services/authentication.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:resideo_eshopping/controller/app_localizations.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resideo e-Shopping',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Resideo e-Shopping'),
      supportedLocales: [
        const Locale('en','US'),
        const Locale('sk','SK'),
      ],
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        // Check if the current device locale is supported
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        // If the locale of the device is not supported, use the first one
        // from the list (English, in this case).
        return supportedLocales.first;
      },
      home: RootPage(auth: Auth()),
    );
  }
}