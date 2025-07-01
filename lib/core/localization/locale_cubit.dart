import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/helpers/storage_helper.dart';

class LocaleCubit extends Cubit<Locale> {
  LocaleCubit() : super(const Locale('ar')) {
    loadSavedLocale();
  }

  Future<void> loadSavedLocale() async {
    final saved = await StorageHelper.getData('lang_code');
    if (saved != null) emit(Locale(saved));
  }

  Future<void> toggleLocale() async {
    final newLocale = state.languageCode == 'ar' ? const Locale('en') : const Locale('ar');
    await StorageHelper.saveData('lang_code', newLocale.languageCode);
    emit(newLocale);
  }
}
