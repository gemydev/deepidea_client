import '../../constants/ui.dart';
import '../localization/controller/locale_storage.dart';

void setLocal() async {
  LocalStorage localStorage = LocalStorage();
  String savedLanguage = await localStorage.languageSelected;
  defaultLocale = savedLanguage;
}