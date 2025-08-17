import 'package:get/get.dart';

import 'languages/ar.dart';
import 'languages/bn.dart';
import 'languages/en.dart';
import 'languages/es.dart';
import 'languages/id.dart';
import 'languages/ku.dart';
import 'languages/ms.dart';
import 'languages/tr.dart';
import 'languages/ur.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': ar,
        'en': en,
        'bn': bn,
        'id': id,
        'ur': ur,
        'tr': tr,
        'ku': ku,
        'ms': ms,
        'es': es,
      };
}
