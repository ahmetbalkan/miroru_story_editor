// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class L10nEn extends L10n {
  L10nEn([String locale = 'en']) : super(locale);

  @override
  String get draw => 'Çiz';

  @override
  String get save => 'Kaydet';

  @override
  String get done => 'Bitti';

  @override
  String get undo => 'Geri Al';

  @override
  String get export_failure => 'Resim dışa aktarılamadı.';

  @override
  String get export_success => 'Resim başarıyla dışa aktarıldı.';
}
