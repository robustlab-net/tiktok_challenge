import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tiktok_challenge/features/settings/repositories/dark_mode_repository.dart';

class DarkModeViewModel extends StateNotifier<bool> {
  final DarkModeRepository _repository;

  DarkModeViewModel(this._repository) : super(_repository.isDarkMode());

  void setDarkMode(bool value) {
    _repository.setDarkMode(value);
    state = value;
  }
}

// SharedPreferences provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

// Repository provider
final darkModeRepositoryProvider = Provider<DarkModeRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return DarkModeRepository(prefs);
});

// ViewModel provider
final darkModeProvider = StateNotifierProvider<DarkModeViewModel, bool>((ref) {
  final repository = ref.watch(darkModeRepositoryProvider);
  return DarkModeViewModel(repository);
});
