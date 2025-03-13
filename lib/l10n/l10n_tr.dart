// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class L10nTr extends L10n {
  L10nTr([String locale = 'tr']) : super(locale);

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
