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

  /// `Welcome to Tamweeny`
  String get welcome {
    return Intl.message(
      'Welcome to Tamweeny',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `For Food Supply`
  String get welcomeSubtitle {
    return Intl.message(
      'For Food Supply',
      name: 'welcomeSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Log in to your account`
  String get logInTitle {
    return Intl.message(
      'Log in to your account',
      name: 'logInTitle',
      desc: '',
      args: [],
    );
  }

  /// `E-Mail`
  String get email {
    return Intl.message(
      'E-Mail',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get staySignedIn {
    return Intl.message(
      'Remember me',
      name: 'staySignedIn',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get signUp {
    return Intl.message(
      'Sign up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `yes`
  String get yes {
    return Intl.message(
      'yes',
      name: 'yes',
      desc: '',
      args: [],
    );
  }

  /// `no`
  String get no {
    return Intl.message(
      'no',
      name: 'no',
      desc: '',
      args: [],
    );
  }

  /// `Do you own a Tamween card?`
  String get ownCard {
    return Intl.message(
      'Do you own a Tamween card?',
      name: 'ownCard',
      desc: '',
      args: [],
    );
  }

  /// `Conditions for Obtaining a New Food Card:`
  String get foodCardConditions {
    return Intl.message(
      'Conditions for Obtaining a New Food Card:',
      name: 'foodCardConditions',
      desc: '',
      args: [],
    );
  }

  /// `1) According to sociological research, the applicant for the new food card must be educated, unemployed, and have a monthly income not exceeding 800 Egyptian Pounds.`
  String get condition1 {
    return Intl.message(
      '1) According to sociological research, the applicant for the new food card must be educated, unemployed, and have a monthly income not exceeding 800 Egyptian Pounds.',
      name: 'condition1',
      desc: '',
      args: [],
    );
  }

  /// `2) Be a retiree working in the public sector or private sector receiving a maximum salary of 1200 Egyptian Pounds monthly.`
  String get condition2 {
    return Intl.message(
      '2) Be a retiree working in the public sector or private sector receiving a maximum salary of 1200 Egyptian Pounds monthly.',
      name: 'condition2',
      desc: '',
      args: [],
    );
  }

  /// `3) Work in the public sector or private sector with a monthly salary of up to 1500 Egyptian Pounds.`
  String get condition3 {
    return Intl.message(
      '3) Work in the public sector or private sector with a monthly salary of up to 1500 Egyptian Pounds.',
      name: 'condition3',
      desc: '',
      args: [],
    );
  }

  /// `Categories Eligible for the New Food Card:`
  String get eligibleCategories {
    return Intl.message(
      'Categories Eligible for the New Food Card:',
      name: 'eligibleCategories',
      desc: '',
      args: [],
    );
  }

  /// `There are several categories deserving of the new food card, and these are the following:`
  String get categoriesList {
    return Intl.message(
      'There are several categories deserving of the new food card, and these are the following:',
      name: 'categoriesList',
      desc: '',
      args: [],
    );
  }

  /// `1) Individuals receiving social assistance.`
  String get category1 {
    return Intl.message(
      '1) Individuals receiving social assistance.',
      name: 'category1',
      desc: '',
      args: [],
    );
  }

  /// `2) Divorced individuals.`
  String get category2 {
    return Intl.message(
      '2) Divorced individuals.',
      name: 'category2',
      desc: '',
      args: [],
    );
  }

  /// `3) Citizens receiving a blessed and Sadat pension.`
  String get category3 {
    return Intl.message(
      '3) Citizens receiving a blessed and Sadat pension.',
      name: 'category3',
      desc: '',
      args: [],
    );
  }

  /// `4) Individuals without a fixed income or supporter.`
  String get category4 {
    return Intl.message(
      '4) Individuals without a fixed income or supporter.',
      name: 'category4',
      desc: '',
      args: [],
    );
  }

  /// `5) Casual and temporary labor, such as agricultural workers, street vendors, and drivers.`
  String get category5 {
    return Intl.message(
      '5) Casual and temporary labor, such as agricultural workers, street vendors, and drivers.',
      name: 'category5',
      desc: '',
      args: [],
    );
  }

  /// `6) Craftsmen and low-income or unemployed workers.`
  String get category6 {
    return Intl.message(
      '6) Craftsmen and low-income or unemployed workers.',
      name: 'category6',
      desc: '',
      args: [],
    );
  }

  /// `7) Qualified youth who have not been employed yet.`
  String get category7 {
    return Intl.message(
      '7) Qualified youth who have not been employed yet.',
      name: 'category7',
      desc: '',
      args: [],
    );
  }

  /// `8) Employee's salary not exceeding 1500 Egyptian Pounds monthly.`
  String get category8 {
    return Intl.message(
      '8) Employee\'s salary not exceeding 1500 Egyptian Pounds monthly.',
      name: 'category8',
      desc: '',
      args: [],
    );
  }

  /// `9) Citizens with chronic illnesses and disabilities.`
  String get category9 {
    return Intl.message(
      '9) Citizens with chronic illnesses and disabilities.',
      name: 'category9',
      desc: '',
      args: [],
    );
  }

  /// `10) Retirees working in both the public and private sectors.`
  String get category10 {
    return Intl.message(
      '10) Retirees working in both the public and private sectors.',
      name: 'category10',
      desc: '',
      args: [],
    );
  }

  /// `Procedures at the Office to Obtain a New Card:`
  String get proceduresForNewCard {
    return Intl.message(
      'Procedures at the Office to Obtain a New Card:',
      name: 'proceduresForNewCard',
      desc: '',
      args: [],
    );
  }

  /// `1) Head to the nearest Ministry of Supply office to obtain the card.`
  String get procedure1 {
    return Intl.message(
      '1) Head to the nearest Ministry of Supply office to obtain the card.',
      name: 'procedure1',
      desc: '',
      args: [],
    );
  }

  /// `2) Submit all the mentioned documents and papers as discussed in this topic.`
  String get procedure2 {
    return Intl.message(
      '2) Submit all the mentioned documents and papers as discussed in this topic.',
      name: 'procedure2',
      desc: '',
      args: [],
    );
  }

  /// `3) Wait until the card is received.`
  String get procedure3 {
    return Intl.message(
      '3) Wait until the card is received.',
      name: 'procedure3',
      desc: '',
      args: [],
    );
  }

  /// `Required Documents for a New Food Card:`
  String get requiredDocuments {
    return Intl.message(
      'Required Documents for a New Food Card:',
      name: 'requiredDocuments',
      desc: '',
      args: [],
    );
  }

  /// `1) Bring a copy of the marriage contract for the cardholder.`
  String get document1 {
    return Intl.message(
      '1) Bring a copy of the marriage contract for the cardholder.',
      name: 'document1',
      desc: '',
      args: [],
    );
  }

  /// `2) Copy of the national ID for the head of the family.`
  String get document2 {
    return Intl.message(
      '2) Copy of the national ID for the head of the family.',
      name: 'document2',
      desc: '',
      args: [],
    );
  }

  /// `3) Copies of national IDs for all cardholders.`
  String get document3 {
    return Intl.message(
      '3) Copies of national IDs for all cardholders.',
      name: 'document3',
      desc: '',
      args: [],
    );
  }

  /// `4) The cardholder must attach a copy of the salary statement if there is any document indicating the monthly salary.`
  String get document4 {
    return Intl.message(
      '4) The cardholder must attach a copy of the salary statement if there is any document indicating the monthly salary.',
      name: 'document4',
      desc: '',
      args: [],
    );
  }

  /// `5) Attach birth certificates for minor children.`
  String get document5 {
    return Intl.message(
      '5) Attach birth certificates for minor children.',
      name: 'document5',
      desc: '',
      args: [],
    );
  }

  /// `Process for Obtaining a Replacement Food Card:`
  String get replacementCardProcess {
    return Intl.message(
      'Process for Obtaining a Replacement Food Card:',
      name: 'replacementCardProcess',
      desc: '',
      args: [],
    );
  }

  /// `1) Copy of the national ID for the cardholder.`
  String get replacementDocument1 {
    return Intl.message(
      '1) Copy of the national ID for the cardholder.',
      name: 'replacementDocument1',
      desc: '',
      args: [],
    );
  }

  /// `2) Send a postal transfer of 20 Egyptian Pounds.`
  String get replacementDocument2 {
    return Intl.message(
      '2) Send a postal transfer of 20 Egyptian Pounds.',
      name: 'replacementDocument2',
      desc: '',
      args: [],
    );
  }

  /// `3) Enter the mobile phone number of the cardholder.`
  String get replacementDocument3 {
    return Intl.message(
      '3) Enter the mobile phone number of the cardholder.',
      name: 'replacementDocument3',
      desc: '',
      args: [],
    );
  }

  /// `4) Bring the latest electricity bill.`
  String get replacementDocument4 {
    return Intl.message(
      '4) Bring the latest electricity bill.',
      name: 'replacementDocument4',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `National Number`
  String get national_number {
    return Intl.message(
      'National Number',
      name: 'national_number',
      desc: '',
      args: [],
    );
  }

  /// `Telephone Number`
  String get telephone_number {
    return Intl.message(
      'Telephone Number',
      name: 'telephone_number',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Building Number/Street Name`
  String get building_number_street_name {
    return Intl.message(
      'Building Number/Street Name',
      name: 'building_number_street_name',
      desc: '',
      args: [],
    );
  }

  /// `Birth Date`
  String get birth_date {
    return Intl.message(
      'Birth Date',
      name: 'birth_date',
      desc: '',
      args: [],
    );
  }

  /// `Name Registered on the Tamween Card`
  String get name_registered_on_tamween_card {
    return Intl.message(
      'Name Registered on the Tamween Card',
      name: 'name_registered_on_tamween_card',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get resume {
    return Intl.message(
      'Continue',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `National Number on Tamween Card`
  String get national_number_on_tamween_card {
    return Intl.message(
      'National Number on Tamween Card',
      name: 'national_number_on_tamween_card',
      desc: '',
      args: [],
    );
  }

  /// `Tamween Card Number`
  String get tamween_card_number {
    return Intl.message(
      'Tamween Card Number',
      name: 'tamween_card_number',
      desc: '',
      args: [],
    );
  }

  /// `Tamween Card Password`
  String get tamween_password {
    return Intl.message(
      'Tamween Card Password',
      name: 'tamween_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Customer Information`
  String get customer_information {
    return Intl.message(
      'Customer Information',
      name: 'customer_information',
      desc: '',
      args: [],
    );
  }

  /// `Tamween Card Information`
  String get tamween_card_information {
    return Intl.message(
      'Tamween Card Information',
      name: 'tamween_card_information',
      desc: '',
      args: [],
    );
  }

  /// `Passwords must match`
  String get passwords_must_match {
    return Intl.message(
      'Passwords must match',
      name: 'passwords_must_match',
      desc: '',
      args: [],
    );
  }

  /// `Error in entering data`
  String get data_entry_error {
    return Intl.message(
      'Error in entering data',
      name: 'data_entry_error',
      desc: '',
      args: [],
    );
  }

  /// `Account Information`
  String get account_information {
    return Intl.message(
      'Account Information',
      name: 'account_information',
      desc: '',
      args: [],
    );
  }

  /// `Order History`
  String get order_history {
    return Intl.message(
      'Order History',
      name: 'order_history',
      desc: '',
      args: [],
    );
  }

  /// `Offers`
  String get offers {
    return Intl.message(
      'Offers',
      name: 'offers',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Wallet Balance`
  String get wallet_balance {
    return Intl.message(
      'Wallet Balance',
      name: 'wallet_balance',
      desc: '',
      args: [],
    );
  }

  /// `Previous Month Balance`
  String get previous_month_balance {
    return Intl.message(
      'Previous Month Balance',
      name: 'previous_month_balance',
      desc: '',
      args: [],
    );
  }

  /// `Current Month Balance`
  String get current_month_balance {
    return Intl.message(
      'Current Month Balance',
      name: 'current_month_balance',
      desc: '',
      args: [],
    );
  }

  /// `Get Help`
  String get get_help {
    return Intl.message(
      'Get Help',
      name: 'get_help',
      desc: '',
      args: [],
    );
  }

  /// `About the App`
  String get about_the_app {
    return Intl.message(
      'About the App',
      name: 'about_the_app',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get sign_out {
    return Intl.message(
      'Sign Out',
      name: 'sign_out',
      desc: '',
      args: [],
    );
  }

  /// `Apply for Tamween Card`
  String get apply_for_tamween_card {
    return Intl.message(
      'Apply for Tamween Card',
      name: 'apply_for_tamween_card',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get gender {
    return Intl.message(
      'Gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Marital Status`
  String get marital_status {
    return Intl.message(
      'Marital Status',
      name: 'marital_status',
      desc: '',
      args: [],
    );
  }

  /// `Minimum Salary`
  String get minimum_salary {
    return Intl.message(
      'Minimum Salary',
      name: 'minimum_salary',
      desc: '',
      args: [],
    );
  }

  /// `ID and Birth Certificate`
  String get id_and_birth_certificate {
    return Intl.message(
      'ID and Birth Certificate',
      name: 'id_and_birth_certificate',
      desc: '',
      args: [],
    );
  }

  /// `Dependents' ID and Birth Certificate`
  String get dependents_id_and_birth_certificate {
    return Intl.message(
      'Dependents\' ID and Birth Certificate',
      name: 'dependents_id_and_birth_certificate',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Single`
  String get single {
    return Intl.message(
      'Single',
      name: 'single',
      desc: '',
      args: [],
    );
  }

  /// `Married`
  String get married {
    return Intl.message(
      'Married',
      name: 'married',
      desc: '',
      args: [],
    );
  }

  /// `Divorced`
  String get divorced {
    return Intl.message(
      'Divorced',
      name: 'divorced',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number.`
  String get please_enter_valid_number {
    return Intl.message(
      'Please enter a valid number.',
      name: 'please_enter_valid_number',
      desc: '',
      args: [],
    );
  }

  /// `Please fill out this field.`
  String get please_fill_out_this_field {
    return Intl.message(
      'Please fill out this field.',
      name: 'please_fill_out_this_field',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Remaining`
  String get remaining {
    return Intl.message(
      'Remaining',
      name: 'remaining',
      desc: '',
      args: [],
    );
  }

  /// `Recommended Foods`
  String get recommended_foods {
    return Intl.message(
      'Recommended Foods',
      name: 'recommended_foods',
      desc: '',
      args: [],
    );
  }

  /// `Most Popular`
  String get most_popular {
    return Intl.message(
      'Most Popular',
      name: 'most_popular',
      desc: '',
      args: [],
    );
  }

  /// `Unit Price`
  String get unit_price {
    return Intl.message(
      'Unit Price',
      name: 'unit_price',
      desc: '',
      args: [],
    );
  }

  /// `Favorite Products`
  String get favorite_products {
    return Intl.message(
      'Favorite Products',
      name: 'favorite_products',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_account {
    return Intl.message(
      'Delete Account',
      name: 'delete_account',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete your account?`
  String get confirm_delete_account {
    return Intl.message(
      'Are you sure you want to delete your account?',
      name: 'confirm_delete_account',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be undone.`
  String get action_cannot_be_undone {
    return Intl.message(
      'This action cannot be undone.',
      name: 'action_cannot_be_undone',
      desc: '',
      args: [],
    );
  }

  /// `Shopping Cart`
  String get shopping_cart {
    return Intl.message(
      'Shopping Cart',
      name: 'shopping_cart',
      desc: '',
      args: [],
    );
  }

  /// `Add More`
  String get add_more {
    return Intl.message(
      'Add More',
      name: 'add_more',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkout {
    return Intl.message(
      'Checkout',
      name: 'checkout',
      desc: '',
      args: [],
    );
  }

  /// `Total Payments`
  String get total_payments {
    return Intl.message(
      'Total Payments',
      name: 'total_payments',
      desc: '',
      args: [],
    );
  }

  /// `Added to Cart`
  String get added_to_cart {
    return Intl.message(
      'Added to Cart',
      name: 'added_to_cart',
      desc: '',
      args: [],
    );
  }

  /// `Order made successfully`
  String get order_success {
    return Intl.message(
      'Order made successfully',
      name: 'order_success',
      desc: '',
      args: [],
    );
  }

  /// `Operation number `
  String get operation_number {
    return Intl.message(
      'Operation number ',
      name: 'operation_number',
      desc: '',
      args: [],
    );
  }

  /// `completed successfully`
  String get success {
    return Intl.message(
      'completed successfully',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Date `
  String get date {
    return Intl.message(
      'Date ',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Today's Orders List`
  String get today_orders_list {
    return Intl.message(
      'Today\'s Orders List',
      name: 'today_orders_list',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get order_details {
    return Intl.message(
      'Order Details',
      name: 'order_details',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get an_error_occurred {
    return Intl.message(
      'An error occurred',
      name: 'an_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get product_name {
    return Intl.message(
      'Product Name',
      name: 'product_name',
      desc: '',
      args: [],
    );
  }

  /// `Quantity`
  String get quantity {
    return Intl.message(
      'Quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
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
