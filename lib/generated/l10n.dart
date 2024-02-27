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

  /// `Learning is Everything`
  String get introduction_title {
    return Intl.message(
      'Learning is Everything',
      name: 'introduction_title',
      desc: '',
      args: [],
    );
  }

  /// `Learning with Pleasure with Dear Programmer, Whenever you are.`
  String get introduction_subtitle {
    return Intl.message(
      'Learning with Pleasure with Dear Programmer, Whenever you are.',
      name: 'introduction_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Get Start`
  String get introduction_button {
    return Intl.message(
      'Get Start',
      name: 'introduction_button',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login_Login {
    return Intl.message(
      'Login',
      name: 'login_Login',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get login_phone_number {
    return Intl.message(
      'Phone Number',
      name: 'login_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get login_email {
    return Intl.message(
      'Email',
      name: 'login_email',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email`
  String get login_email_valid {
    return Intl.message(
      'Please Enter Your Email',
      name: 'login_email_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Phone`
  String get login_phone_number_valid {
    return Intl.message(
      'Please Enter Your Phone',
      name: 'login_phone_number_valid',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Password`
  String get login_password_valid {
    return Intl.message(
      'Please Enter Your Password',
      name: 'login_password_valid',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get login_password {
    return Intl.message(
      'Password',
      name: 'login_password',
      desc: '',
      args: [],
    );
  }

  /// `Already have an Account?`
  String get login_have_an_account {
    return Intl.message(
      'Already have an Account?',
      name: 'login_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get login_sign_up {
    return Intl.message(
      'Sign Up',
      name: 'login_sign_up',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get register_name {
    return Intl.message(
      'Name',
      name: 'register_name',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Name`
  String get register_name_valid {
    return Intl.message(
      'Please Enter Your Name',
      name: 'register_name_valid',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password ?`
  String get login_forget_password {
    return Intl.message(
      'Forget Password ?',
      name: 'login_forget_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to receive a code`
  String get forget_password_title {
    return Intl.message(
      'Please enter your email to receive a code',
      name: 'forget_password_title',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get forget_password_button {
    return Intl.message(
      'Send',
      name: 'forget_password_button',
      desc: '',
      args: [],
    );
  }

  /// `Media Lexicon`
  String get settings_logo {
    return Intl.message(
      'Media Lexicon',
      name: 'settings_logo',
      desc: '',
      args: [],
    );
  }

  /// `The Application Language is English`
  String get settings_title_language {
    return Intl.message(
      'The Application Language is English',
      name: 'settings_title_language',
      desc: '',
      args: [],
    );
  }

  /// `The theme mode is Light`
  String get settings_title_them {
    return Intl.message(
      'The theme mode is Light',
      name: 'settings_title_them',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get setting_button {
    return Intl.message(
      'Change',
      name: 'setting_button',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
