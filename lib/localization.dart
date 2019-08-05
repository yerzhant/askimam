import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:askimam/l10n/messages_all.dart';

/*
flutter packages pub run intl_translation:extract_to_arb --output-dir=lib/l10n lib/localization.dart
flutter packages pub run intl_translation:generate_from_arb --output-dir=lib/l10n --no-use-deferred-loading lib/localization.dart lib/l10n/intl_*.arb
*/

class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get appName {
    return Intl.message(
      'Вопрос имаму Azan.kz',
      name: 'appName',
    );
  }

  String get enteringIntoSystem {
    return Intl.message(
      'Вход в систему...',
      name: 'enteringIntoSystem',
    );
  }

  String get publicQuestions {
    return Intl.message(
      'Публичные вопросы',
      name: 'publicQuestions',
    );
  }

  String get myQuestions {
    return Intl.message(
      'Мои вопросы',
      name: 'myQuestions',
    );
  }

  String get newQuestions {
    return Intl.message(
      'Новые вопросы',
      name: 'newQuestions',
    );
  }

  String get askQuestion {
    return Intl.message(
      'Задать вопрос',
      name: 'askQuestion',
    );
  }

  String get deleteQuestions {
    return Intl.message(
      'Удалить вопросы',
      name: 'deleteQuestions',
    );
  }

  String get confidentialityPolicy {
    return Intl.message(
      'Политика конфиденциальности',
      name: 'confidentialityPolicy',
    );
  }

  String get enterMessage {
    return Intl.message(
      'Введите сообщение',
      name: 'enterMessage',
    );
  }

  String get sendMessage {
    return Intl.message(
      'Отправить сообщение',
      name: 'sendMessage',
    );
  }

  String get returnToNewQuestions {
    return Intl.message(
      'Вернуть в Новые вопросы',
      name: 'returnToNewQuestions',
    );
  }

  String get returnToListOfNewQuestions {
    return Intl.message(
      'Вернуть вопрос в список Новых вопросов?',
      name: 'returnToListOfNewQuestions',
    );
  }

  String get myMessages {
    return Intl.message(
      'Мои переписки',
      name: 'myMessages',
    );
  }

  String get hasNewMessage {
    return Intl.message(
      'Есть новое сообщение',
      name: 'hasNewMessage',
    );
  }

  String get subject {
    return Intl.message(
      'Тема',
      name: 'subject',
    );
  }

  String get enterSubject {
    return Intl.message(
      'Введите тему',
      name: 'enterSubject',
    );
  }

  String get pleaseEnterSubject {
    return Intl.message(
      'Пожалуйста, введите тему',
      name: 'pleaseEnterSubject',
    );
  }

  String get privateQuestion {
    return Intl.message(
      'Приватный вопрос',
      name: 'privateQuestion',
    );
  }

  String get publicQuestion {
    return Intl.message(
      'Публичный вопрос',
      name: 'publicQuestion',
    );
  }

  String get enterQuestion {
    return Intl.message(
      'Введите вопрос',
      name: 'enterQuestion',
    );
  }

  String get pleaseEnterQuestion {
    return Intl.message(
      'Пожалуйста, введите вопрос',
      name: 'pleaseEnterQuestion',
    );
  }

  String get send {
    return Intl.message(
      'Отправить',
      name: 'send',
    );
  }

  String get imamRegistrationConfirmation {
    return Intl.message(
      'Ваша заявка принята. Пожалуйста, перезапустите '
      'приложение после подтверждения Вашей заявки.',
      name: 'imamRegistrationConfirmation',
    );
  }

  String get imamsRating {
    return Intl.message(
      'Рейтинг устазов',
      name: 'imamsRating',
    );
  }

  String get searchPrompt {
    return Intl.message(
      'Введите искомое слово/выражение',
      name: 'searchPrompt',
    );
  }

  String get share {
    return Intl.message(
      'Поделиться',
      name: 'share',
    );
  }

  String get teacher {
    return Intl.message(
      'Устаз',
      name: 'teacher',
    );
  }

  String get audioMessage {
    return Intl.message(
      'Аудио сообщение',
      name: 'audioMessage',
    );
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ru', 'kk'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
