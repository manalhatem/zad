import '../local/app_cached.dart';
import '../local/cache_helper.dart';

setThemeMode() {
  CacheHelper.getData(key: AppCached.theme) ??
      CacheHelper.saveData(
          key: AppCached.theme, value: AppCached.lightTheme);
}
