# مكتبة القرآن الكريم - Quran Library Website

موقع شامل يوفر دليلاً تفصيلياً لاستخدام مكتبة القرآن الكريم في تطوير تطبيقات Flutter.

## ✨ الميزات

- 📱 تصميم متجاوب يدعم جميع الأجهزة
- 🌐 دعم اللغة العربية والإنجليزية
- 🎨 واجهة مستخدم حديثة وسهلة الاستخدام
- 🔍 بحث متقدم في المحتوى
- 📚 أمثلة عملية وشاملة
- 🎵 دعم تشغيل الصوت والتلاوة
- 🔖 نظام العلامات المرجعية
- 📖 دعم التفسير
- 🎭 تخصيص الثيمات والخطوط

## 🚀 التقنيات المستخدمة

- **Flutter Web** - لتطوير الواجهة الأمامية
- **Get** - لإدارة الحالة والتنقل
- **GoRouter** - للتوجيه المتقدم
- **Google Fonts** - للخطوط الحديثة
- **Responsive Framework** - للتصميم المتجاوب

## 🛠️ التثبيت والتشغيل

### المتطلبات
- Flutter SDK (3.6.0 أو أحدث)
- Dart SDK
- محرر نصوص (VS Code, Android Studio)

### خطوات التشغيل

1. **استنساخ المشروع**
```bash
git clone https://github.com/alheekmahlib/quran_package_website.git
cd quran_package_website
```

2. **تثبيت التبعيات**
```bash
flutter pub get
```

3. **تشغيل المشروع**
```bash
flutter run -d chrome
```

4. **بناء للنشر**
```bash
flutter build web --release
```

## 📂 هيكل المشروع

```
lib/
├── config/           # إعدادات التطبيق والتوجيه
├── constants/        # الثوابت والثيمات
├── controllers/      # متحكمات الحالة
├── models/           # نماذج البيانات
├── pages/            # صفحات التطبيق
├── services/         # الخدمات (SEO, API)
├── translations/     # ملفات الترجمة
├── widgets/          # المكونات المعاد استخدامها
└── main.dart         # نقطة البداية

web/
├── icons/            # أيقونات التطبيق
├── index.html        # صفحة HTML الرئيسية
├── manifest.json     # إعدادات PWA
├── sitemap.xml       # خريطة الموقع
├── robots.txt        # تعليمات محركات البحث
└── .htaccess         # إعدادات الخادم
```

## 🔧 تحسين SEO

تم تنفيذ أفضل ممارسات SEO في الموقع:

### Meta Tags
- ✅ عناوين ديناميكية لكل صفحة
- ✅ أوصاف مُحسّنة لكل قسم
- ✅ كلمات مفتاحية مستهدفة
- ✅ Open Graph للمشاركة الاجتماعية
- ✅ Twitter Cards

### Technical SEO
- ✅ Sitemap.xml
- ✅ Robots.txt
- ✅ Canonical URLs
- ✅ Structured Data (JSON-LD)
- ✅ Mobile-friendly design
- ✅ Fast loading times

### Performance
- ✅ Code splitting
- ✅ Image optimization
- ✅ Caching headers
- ✅ Compression (gzip)

## 🌐 النشر

### Vercel (مُوصى به)
```bash
# ربط المشروع بـ Vercel
vercel

# أو النشر مباشرة
vercel --prod
```

### Netlify
```bash
# بناء المشروع
flutter build web

# رفع مجلد build/web إلى Netlify
```

### Firebase Hosting
```bash
# تثبيت Firebase CLI
npm install -g firebase-tools

# تسجيل الدخول
firebase login

# تهيئة المشروع
firebase init hosting

# النشر
firebase deploy
```

## 📱 PWA Support

الموقع يدعم Progressive Web App:
- ✅ قابل للتثبيت على الأجهزة
- ✅ يعمل بدون اتصال (Cache)
- ✅ أيقونات متعددة الأحجام
- ✅ Splash screen مخصص

## 🤝 المساهمة

نرحب بالمساهمات! يرجى اتباع الخطوات التالية:

1. Fork المشروع
2. إنشاء branch جديد (`git checkout -b feature/AmazingFeature`)
3. Commit التغييرات (`git commit -m 'Add some AmazingFeature'`)
4. Push إلى البranch (`git push origin feature/AmazingFeature`)
5. فتح Pull Request

## 📄 الترخيص

هذا المشروع مرخص تحت رخصة MIT - انظر ملف [LICENSE](LICENSE) للتفاصيل.

## 📞 التواصل

- **الموقع**: [https://quran-library.vercel.app](https://quran-library.vercel.app)
- **GitHub**: [https://github.com/alheekmahlib](https://github.com/alheekmahlib)
- **البريد الإلكتروني**: contact@alheekmahlib.com

## 🙏 شكر وتقدير

شكر خاص لجميع المساهمين في تطوير هذا المشروع ومكتبة القرآن الكريم.

---

<div align="center">
  <p>صُنع بـ ❤️ للأمة الإسلامية</p>
  <p>Made with ❤️ for the Islamic Ummah</p>
</div>
