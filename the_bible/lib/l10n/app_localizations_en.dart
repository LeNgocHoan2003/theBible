// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'The Bible';

  @override
  String get authTitle => 'Authentication';

  @override
  String get loginTab => 'Login';

  @override
  String get signUpTab => 'Sign Up';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get nameLabel => 'Name';

  @override
  String get loginButton => 'Login';

  @override
  String get createAccountButton => 'Create account';

  @override
  String get receiveNotifications => 'Receive notifications';

  @override
  String get emailRequiredError => 'Email is required';

  @override
  String get emailInvalidError => 'Enter a valid email';

  @override
  String get passwordRequiredError => 'Password is required';

  @override
  String get passwordMinLengthError => 'Password must be at least 6 characters';

  @override
  String get nameRequiredError => 'Name is required';

  @override
  String get homeTitle => 'Scripture';

  @override
  String get logoutAction => 'Logout';

  @override
  String get welcomeBack => 'WELCOME BACK';

  @override
  String get homeHeroTitle =>
      'Explore the\nSacred Word in\nyour preferred\nlanguage.';

  @override
  String get searchPlaceholder => 'Search versions or languages...';

  @override
  String get recommendedForYou => 'RECOMMENDED FOR YOU';

  @override
  String get recommendedVersionTitle => 'New\nInternational\nVersion';

  @override
  String get recommendedVersionSubtitle =>
      'English • Standard Modern English\nTranslation';

  @override
  String get readNow => 'Read Now';

  @override
  String get detailsAction => 'Details →';

  @override
  String get homeNavTitle => 'HOME';

  @override
  String get homeNavSubtitle => 'CLASSIC STUDY';

  @override
  String get libraryNavTitle => 'LIBRARY';

  @override
  String get searchNavTitle => 'SEARCH';
}
