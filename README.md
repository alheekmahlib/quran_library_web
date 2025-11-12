# quran_library_web

واجهة ويب Flutter.

## النشر على GitHub Pages

تم إعداد وركفلو GitHub Actions (`.github/workflows/deploy_pages.yml`) لبناء التطبيق ونشره تلقائياً على GitHub Pages عند أي دفع (push) إلى الفرع `main` أو عند التشغيل اليدوي.

### المسار (Base Href)
يُبنى الموقع باستخدام:

```
flutter build web --release --base-href /quran_library_web/
```

هذا يضمن عمل الأصول والروابط تحت المسار الفرعي الخاص بالمستودع.

### التفعيل الأول
1. من إعدادات المستودع في GitHub، ادخل إلى Settings > Pages.
2. اختر Source: GitHub Actions (إن لم يكن مفعّلاً).
3. بعد أول تنفيذ ناجح سترى الرابط في نفس الصفحة. الرابط المتوقع:
	 `https://alheekmahlib.github.io/quran_library_web/`.

### تشغيل البناء يدوياً
من تبويب Actions اختر "Deploy Flutter Web to GitHub Pages" ثم "Run workflow".

### استكشاف الأخطاء
- تأكد من نجاح `flutter pub get` في السجلات.
- إن تغيّر اسم المستودع أو مسار النشر، حدّث قيمة `--base-href` داخل
	`.github/workflows/deploy_pages.yml`.

## تطوير محلي
لتشغيل محلياً:
```
flutter pub get
flutter run -d chrome
```

لمزيد من المعلومات عن Flutter راجع
[الوثائق الرسمية](https://docs.flutter.dev/).
