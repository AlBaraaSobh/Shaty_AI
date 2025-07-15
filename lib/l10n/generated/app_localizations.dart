import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @login_now.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get login_now;

  /// No description provided for @login_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome, login to your account'**
  String get login_subtitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @hint_email.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get hint_email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @hint_password.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get hint_password;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Password Confirmation'**
  String get confirm_password;

  /// No description provided for @hint_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Password Confirmation'**
  String get hint_confirm_password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account?'**
  String get dont_have_account;

  /// No description provided for @register_through.
  ///
  /// In en, this message translates to:
  /// **'Register through'**
  String get register_through;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'Create a new account'**
  String get create_account;

  /// No description provided for @welcome_to_create_an_Account.
  ///
  /// In en, this message translates to:
  /// **'New Registration\nRegister Now'**
  String get welcome_to_create_an_Account;

  /// No description provided for @sign_in_patient_title.
  ///
  /// In en, this message translates to:
  /// **'Patient'**
  String get sign_in_patient_title;

  /// No description provided for @sign_in_doctor_title.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get sign_in_doctor_title;

  /// No description provided for @hint_enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Enter your Name'**
  String get hint_enter_your_name;

  /// No description provided for @enter_your_name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get enter_your_name;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'specialization'**
  String get specialization;

  /// No description provided for @hint_specialization.
  ///
  /// In en, this message translates to:
  /// **'Chronic diseases'**
  String get hint_specialization;

  /// No description provided for @hint_specialty_id.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get hint_specialty_id;

  /// No description provided for @specialty_id.
  ///
  /// In en, this message translates to:
  /// **'specialtyId'**
  String get specialty_id;

  /// No description provided for @job_number.
  ///
  /// In en, this message translates to:
  /// **'job Number'**
  String get job_number;

  /// No description provided for @hint_job_number.
  ///
  /// In en, this message translates to:
  /// **'40854598826'**
  String get hint_job_number;

  /// No description provided for @login_as_patient.
  ///
  /// In en, this message translates to:
  /// **'Login as Patient'**
  String get login_as_patient;

  /// No description provided for @login_as_doctor.
  ///
  /// In en, this message translates to:
  /// **'Login as Doctor'**
  String get login_as_doctor;

  /// No description provided for @reset_password_title.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get reset_password_title;

  /// No description provided for @reset_password_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email to send the verification code'**
  String get reset_password_subtitle;

  /// No description provided for @send_code.
  ///
  /// In en, this message translates to:
  /// **'Send Code'**
  String get send_code;

  /// No description provided for @check_your_email.
  ///
  /// In en, this message translates to:
  /// **'Check your email'**
  String get check_your_email;

  /// No description provided for @we_sent_code.
  ///
  /// In en, this message translates to:
  /// **'We’ve sent a verification code to your email'**
  String get we_sent_code;

  /// No description provided for @confirm_code.
  ///
  /// In en, this message translates to:
  /// **'Confirm Code'**
  String get confirm_code;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @confirm_new_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirm_new_password;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'search'**
  String get search;

  /// No description provided for @daily_tips.
  ///
  /// In en, this message translates to:
  /// **'Daily Tips'**
  String get daily_tips;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'delete'**
  String get delete;

  /// No description provided for @new_post.
  ///
  /// In en, this message translates to:
  /// **'New Post'**
  String get new_post;

  /// No description provided for @create_new_post.
  ///
  /// In en, this message translates to:
  /// **' Create New Post'**
  String get create_new_post;

  /// No description provided for @post.
  ///
  /// In en, this message translates to:
  /// **'Post'**
  String get post;

  /// No description provided for @topic.
  ///
  /// In en, this message translates to:
  /// **'Topic'**
  String get topic;

  /// No description provided for @add_daily_tips.
  ///
  /// In en, this message translates to:
  /// **'Add daily advice'**
  String get add_daily_tips;

  /// No description provided for @edit_daily_tips.
  ///
  /// In en, this message translates to:
  /// **'Edit daily advice'**
  String get edit_daily_tips;

  /// No description provided for @followers.
  ///
  /// In en, this message translates to:
  /// **'Followers'**
  String get followers;

  /// No description provided for @articles.
  ///
  /// In en, this message translates to:
  /// **'Articles'**
  String get articles;

  /// No description provided for @tips.
  ///
  /// In en, this message translates to:
  /// **'Tips'**
  String get tips;

  /// No description provided for @biography.
  ///
  /// In en, this message translates to:
  /// **'Biography'**
  String get biography;

  /// No description provided for @view_all.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get view_all;

  /// No description provided for @change_password.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get change_password;

  /// No description provided for @archives.
  ///
  /// In en, this message translates to:
  /// **'Archives'**
  String get archives;

  /// No description provided for @manage_notifications.
  ///
  /// In en, this message translates to:
  /// **'Manage Notifications'**
  String get manage_notifications;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @logout_title.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to leave the account?'**
  String get logout_title;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'share'**
  String get share;

  /// No description provided for @comment.
  ///
  /// In en, this message translates to:
  /// **'comment'**
  String get comment;

  /// No description provided for @like.
  ///
  /// In en, this message translates to:
  /// **'like'**
  String get like;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'title'**
  String get title;

  /// No description provided for @hint_title.
  ///
  /// In en, this message translates to:
  /// **'What is the title of the post?'**
  String get hint_title;

  /// No description provided for @hint_subject.
  ///
  /// In en, this message translates to:
  /// **'Write your article here?'**
  String get hint_subject;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get comments;

  /// No description provided for @no_comments.
  ///
  /// In en, this message translates to:
  /// **'There are no comments yet'**
  String get no_comments;

  /// No description provided for @write_comments.
  ///
  /// In en, this message translates to:
  /// **'Write your comment here..'**
  String get write_comments;

  /// No description provided for @edit_comments.
  ///
  /// In en, this message translates to:
  /// **'Edit Comments'**
  String get edit_comments;

  /// No description provided for @delete_comments.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete your comment?'**
  String get delete_comments;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fill_all_fields.
  ///
  /// In en, this message translates to:
  /// **'Fill All Fields'**
  String get fill_all_fields;

  /// No description provided for @passwords_do_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords Do Not Match'**
  String get passwords_do_not_match;

  /// No description provided for @current_password.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get current_password;

  /// No description provided for @my_articles.
  ///
  /// In en, this message translates to:
  /// **'My Articles'**
  String get my_articles;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **':Language'**
  String get language;

  /// No description provided for @edit_profile.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get edit_profile;

  /// No description provided for @doctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctors;

  /// No description provided for @specialties.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get specialties;

  /// No description provided for @not_followed.
  ///
  /// In en, this message translates to:
  /// **'You have not followed any doctor yet'**
  String get not_followed;

  /// No description provided for @un_follow.
  ///
  /// In en, this message translates to:
  /// **'Unfollow'**
  String get un_follow;

  /// No description provided for @follow.
  ///
  /// In en, this message translates to:
  /// **'Follow'**
  String get follow;

  /// No description provided for @no_doctors_for_this_specialty.
  ///
  /// In en, this message translates to:
  /// **'There are currently no doctors for this specialty'**
  String get no_doctors_for_this_specialty;

  /// No description provided for @no_tips.
  ///
  /// In en, this message translates to:
  /// **'There are no tips currently'**
  String get no_tips;

  /// No description provided for @specialty_cardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get specialty_cardiology;

  /// No description provided for @specialty_surgery.
  ///
  /// In en, this message translates to:
  /// **'General Surgery'**
  String get specialty_surgery;

  /// No description provided for @specialty_internal.
  ///
  /// In en, this message translates to:
  /// **'Internal Medicine'**
  String get specialty_internal;

  /// No description provided for @specialty_dermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology'**
  String get specialty_dermatology;

  /// No description provided for @specialty_neurology.
  ///
  /// In en, this message translates to:
  /// **'Neurology'**
  String get specialty_neurology;

  /// No description provided for @specialty_psychiatry.
  ///
  /// In en, this message translates to:
  /// **'Psychiatry'**
  String get specialty_psychiatry;

  /// No description provided for @specialty_gynecology.
  ///
  /// In en, this message translates to:
  /// **'Gynecology and Obstetrics'**
  String get specialty_gynecology;

  /// No description provided for @specialty_pediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get specialty_pediatrics;

  /// No description provided for @specialty_oncology.
  ///
  /// In en, this message translates to:
  /// **'Oncology'**
  String get specialty_oncology;

  /// No description provided for @specialty_neurosurgery.
  ///
  /// In en, this message translates to:
  /// **'Neurosurgery'**
  String get specialty_neurosurgery;

  /// No description provided for @no_saved_article.
  ///
  /// In en, this message translates to:
  /// **'There are no articles saved yet'**
  String get no_saved_article;

  /// No description provided for @no_notifications.
  ///
  /// In en, this message translates to:
  /// **'There are no notifications currently.'**
  String get no_notifications;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
