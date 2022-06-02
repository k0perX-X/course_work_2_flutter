// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Patient Application`
  String get appTitle {
    return Intl.message(
      'Patient Application',
      name: 'appTitle',
      desc: 'Название приложения',
      args: [],
    );
  }

  /// `An error occurred while logging in. Check the correctness of the entered data and try again.`
  String get loginErrorNote {
    return Intl.message(
      'An error occurred while logging in. Check the correctness of the entered data and try again.',
      name: 'loginErrorNote',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get loginErrorTitle {
    return Intl.message(
      'Error',
      name: 'loginErrorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Sing in`
  String get loginSingIn {
    return Intl.message(
      'Sing in',
      name: 'loginSingIn',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get loginWelcomeTitle {
    return Intl.message(
      'Welcome',
      name: 'loginWelcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get navBarHome {
    return Intl.message(
      'Home',
      name: 'navBarHome',
      desc: 'Домашнее меню',
      args: [],
    );
  }

  /// `Medicine`
  String get navBarMedicine {
    return Intl.message(
      'Medicine',
      name: 'navBarMedicine',
      desc: 'Меню с лекарствами',
      args: [],
    );
  }

  /// `Settings`
  String get navBarSettings {
    return Intl.message(
      'Settings',
      name: 'navBarSettings',
      desc: 'Меню настроек',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
