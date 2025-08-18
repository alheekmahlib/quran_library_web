import 'package:universal_html/html.dart' as html;

class SEOService {
  static const String defaultTitle = 'مكتبة القرآن الكريم - Quran Library';
  static const String defaultDescription =
      'دليل شامل لتطوير تطبيقات القرآن الكريم باستخدام Flutter. تعلم كيفية إنشاء تطبيقات قرآنية مع ميزات الصوت والبحث والتفسير والمزيد.';
  static const String baseUrl =
      'https://alheekmahlib.github.io/quran_library_web';

  /// Update page title and meta tags for SEO
  static void updatePageSEO({
    required String title,
    required String description,
    required String path,
    List<String>? keywords,
    String? image,
  }) {
    try {
      // Update title
      html.document.title = '$title | $defaultTitle';

      // Update meta description
      _updateMetaTag('name', 'description', description);

      // Update keywords if provided
      if (keywords != null && keywords.isNotEmpty) {
        _updateMetaTag('name', 'keywords', keywords.join(', '));
      }

      // Update Open Graph tags
      _updateMetaTag('property', 'og:title', title);
      _updateMetaTag('property', 'og:description', description);
      _updateMetaTag('property', 'og:url', '$baseUrl$path');

      if (image != null) {
        _updateMetaTag('property', 'og:image', image);
      }

      // Update Twitter tags
      _updateMetaTag('property', 'twitter:title', title);
      _updateMetaTag('property', 'twitter:description', description);
      _updateMetaTag('property', 'twitter:url', '$baseUrl$path');

      if (image != null) {
        _updateMetaTag('property', 'twitter:image', image);
      }

      // Update canonical URL
      _updateCanonicalUrl('$baseUrl$path');
    } catch (e) {
      // Silently handle errors if DOM is not available or on non-web platforms
      print('SEO update skipped: $e');
    }
  }

  /// Get SEO data for specific section
  static Map<String, dynamic> getSEODataForSection(String sectionKey) {
    switch (sectionKey) {
      case 'what_is_quran_library':
        return {
          'title': 'ما هي مكتبة القرآن الكريم؟',
          'description':
              'تعرف على مكتبة القرآن الكريم، مكتبة Flutter شاملة لإنشاء تطبيقات قرآنية متطورة مع دعم العربية والميزات الحديثة.',
          'keywords': [
            'مكتبة القرآن',
            'Flutter',
            'تطوير التطبيقات',
            'القرآن الكريم',
            'البرمجة العربية'
          ],
        };
      case 'installation':
        return {
          'title': 'تثبيت مكتبة القرآن الكريم',
          'description':
              'دليل خطوة بخطوة لتثبيت مكتبة القرآن الكريم في مشروع Flutter الخاص بك وبدء تطوير تطبيقات قرآنية.',
          'keywords': ['تثبيت', 'Flutter package', 'pubspec.yaml', 'التثبيت'],
        };
      case 'initial_setup':
        return {
          'title': 'الإعداد الأولي لمكتبة القرآن',
          'description':
              'تعلم كيفية إعداد مكتبة القرآن الكريم في تطبيقك وتهيئة الإعدادات الأساسية للبدء في التطوير.',
          'keywords': ['إعداد', 'تهيئة', 'الإعدادات الأولية', 'Flutter setup'],
        };
      case 'first_example':
        return {
          'title': 'المثال الأول - عرض القرآن الكريم',
          'description':
              'مثال عملي بسيط لعرض آيات القرآن الكريم في تطبيق Flutter باستخدام مكتبة القرآن.',
          'keywords': ['مثال', 'عرض القرآن', 'آيات', 'Flutter example'],
        };
      case 'basic_quran_screen':
        return {
          'title': 'شاشة القرآن الأساسية',
          'description':
              'تعلم كيفية إنشاء شاشة القرآن الأساسية مع عرض السور والآيات بتصميم احترافي.',
          'keywords': ['شاشة القرآن', 'عرض السور', 'تصميم', 'UI/UX'],
        };
      case 'audio_verse_playback':
        return {
          'title': 'تشغيل صوت الآيات',
          'description':
              'دليل شامل لإضافة ميزة تشغيل صوت الآيات القرآنية في تطبيقك مع التحكم في التشغيل.',
          'keywords': ['صوت', 'تشغيل الآيات', 'audio playback', 'تلاوة'],
        };
      case 'audio_surah_playback':
        return {
          'title': 'تشغيل صوت السور',
          'description':
              'تعلم كيفية تنفيذ ميزة تشغيل السور كاملة مع إمكانيات التحكم المتقدمة في التشغيل.',
          'keywords': [
            'تشغيل السور',
            'صوت السورة',
            'audio control',
            'تلاوة كاملة'
          ],
        };
      case 'quran_search':
        return {
          'title': 'البحث في القرآن الكريم',
          'description':
              'تنفيذ ميزة البحث المتقدم في القرآن الكريم مع دعم البحث بالنص العربي والترجمة.',
          'keywords': ['البحث', 'search', 'بحث القرآن', 'البحث المتقدم'],
        };
      case 'bookmarks':
        return {
          'title': 'نظام العلامات المرجعية',
          'description':
              'إضافة نظام العلامات المرجعية للسماح للمستخدمين بحفظ الآيات المفضلة والعودة إليها بسهولة.',
          'keywords': ['علامات مرجعية', 'bookmarks', 'المفضلة', 'حفظ الآيات'],
        };
      case 'download_quran_fonts':
        return {
          'title': 'تحميل خطوط القرآن',
          'description':
              'دليل تحميل وتثبيت الخطوط القرآنية المتخصصة لعرض النص القرآني بأفضل جودة وتصميم.',
          'keywords': ['خطوط القرآن', 'fonts', 'تحميل الخطوط', 'Arabic fonts'],
        };
      case 'tafsir_initialization':
        return {
          'title': 'تهيئة التفسير',
          'description':
              'تعلم كيفية إضافة وتهيئة التفاسير المختلفة في تطبيقك لتوفير شرح وتفسير للآيات القرآنية.',
          'keywords': ['تفسير', 'tafsir', 'شرح الآيات', 'التفسير الإسلامي'],
        };
      default:
        return {
          'title': defaultTitle,
          'description': defaultDescription,
          'keywords': [
            'القرآن الكريم',
            'Flutter',
            'تطوير التطبيقات',
            'مكتبة القرآن'
          ],
        };
    }
  }

  /// Update specific meta tag
  static void _updateMetaTag(
      String attribute, String attributeValue, String content) {
    var existingTag =
        html.document.querySelector('meta[$attribute="$attributeValue"]');
    if (existingTag != null) {
      existingTag.setAttribute('content', content);
    } else {
      var newTag = html.MetaElement();
      newTag.setAttribute(attribute, attributeValue);
      newTag.setAttribute('content', content);
      html.document.head?.append(newTag);
    }
  }

  /// Update canonical URL
  static void _updateCanonicalUrl(String url) {
    var existingLink = html.document.querySelector('link[rel="canonical"]');
    if (existingLink != null) {
      existingLink.setAttribute('href', url);
    } else {
      var newLink = html.LinkElement();
      newLink.rel = 'canonical';
      newLink.href = url;
      html.document.head?.append(newLink);
    }
  }

  /// Add structured data for the current page
  static void addStructuredData(Map<String, dynamic> data) {
    var structuredData = {
      '@context': 'https://schema.org',
      '@type': 'WebPage',
      'name': data['title'],
      'description': data['description'],
      'url': '$baseUrl${data['path'] ?? ''}',
      'inLanguage': 'ar',
      'isPartOf': {
        '@type': 'WebSite',
        'name': defaultTitle,
        'url': baseUrl,
      }
    };

    var script = html.ScriptElement();
    script.type = 'application/ld+json';
    script.text = structuredData.toString().replaceAll("'", '"');

    // Remove existing structured data script if any
    var existingScript =
        html.document.querySelector('script[type="application/ld+json"]');
    if (existingScript != null &&
        existingScript !=
            html.document.querySelector('script[type="application/ld+json"]')) {
      existingScript.remove();
    }

    html.document.head?.append(script);
  }
}
