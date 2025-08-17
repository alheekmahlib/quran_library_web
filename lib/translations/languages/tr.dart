const Map<String, String> tr = {
  // Header
  'app_title': 'Kuran Kütüphanesi',
  'app_subtitle': 'مكتبة القرآن',
  'docs': 'Belgeler',
  'search': 'Arama',

  // Language dropdown
  'arabic': 'العربية',
  'english': 'English',
  'bengali': 'বাংলা',
  'indonesian': 'Bahasa Indonesia',
  'urdu': 'اردو',
  'turkish': 'Türkçe',
  'kurdish': 'کوردی',
  'malaysian': 'Bahasa Malaysia',
  'spanish': 'Español',

  // Sidebar
  'documentation': 'Belgeler',
  'comprehensive_guide': 'Kuran Kütüphanesi kullanımı için kapsamlı rehber',

  // Main sections
  'getting_started': 'Başlangıç',
  'usage_examples': 'Kullanım Örnekleri',
  'utils': 'Yardımcı Araçlar',
  'fonts_download': 'Font İndirme',
  'tafsir': 'Tefsir',
  'audio_playback': 'Ses Oynatma',

  // Getting Started subsections
  'what_is_quran_library': 'Kuran Kütüphanesi nedir?',
  'motivation_behind_library': 'Kütüphanenin arkasındaki motivasyon',
  'installation': 'Kurulum',
  'initial_setup': 'İlk Kurulum',

  // Usage Examples subsections
  'first_example': 'İlk Örnek',
  'basic_quran_screen': 'Temel Kuran Ekranı',
  'individual_surah_display': 'Bireysel Sure Görüntüleme',

  // Utils subsections
  'utility_functions': 'Yardımcı Fonksiyonlar',
  'navigation_jumping': 'Navigasyon ve Atlama',
  'bookmarks': 'Yer İmleri',
  'quran_search': 'Kuran Arama',

  // Fonts Download subsections
  'download_quran_fonts': 'Kuran Fontları İndir',

  // Tafsir subsections
  'tafsir_initialization': 'Tefsir Başlatma',

  // Audio Playback subsections
  'audio_verse_playback': 'Ayet Ses Oynatma',
  'audio_surah_playback': 'Sure Ses Oynatma',
  'audio_download_management': 'İndirme Yönetimi',
  'audio_position_control': 'Pozisyon Kontrolü ve Devam',

  // Old sections for compatibility
  'introduction': 'Giriş',
  'quick_start': 'Hızlı Başlangıç',
  'options_customization': 'Seçenekler ve Özelleştirme',
  'advanced_features': 'Gelişmiş Özellikler',
  'search_functionality': 'Arama İşlevselliği',
  'tafsir_integration': 'Tefsir Entegrasyonu',
  'custom_themes': 'Özel Temalar',
  'customization': 'Özelleştirme',

  // Installation section
  'permissions': 'İzinler',
  'permissions_subtitle': 'İzinler',
  'android_permissions': 'Android',
  'android_permissions_description':
      'Ses oynatma için gerekli izinler (WAKE_LOCK, FOREGROUND_SERVICE ve FOREGROUND_SERVICE_MEDIA_PLAYBACK) paket tarafından otomatik olarak eklenir. AndroidManifest.xml dosyasını manuel olarak düzenlemenize gerek yoktur.',
  'ios_permissions': 'iOS',
  'ios_permissions_description':
      'Arka plan ses oynatma için, uygulamanızın Info.plist dosyasına aşağıdakileri eklemeniz gerekir:',
  'ios_permissions_note':
      'Bu, uygulama arka plandayken ses oynatmanın devam etmesine izin verir.',
  'initialize_library': 'Kütüphaneyi Başlat',

  // Basic Quran Screen
  'basic_quran_simple': 'Kodunuza şu şekilde ekleyebilirsiniz:',
  'advanced_options': 'Gelişmiş Seçenekler',
  'advanced_options_description': 'Veya bazı seçenekler verin:',

  // Individual Surah Display
  'individual_surah_enhanced':
      'Özel sayfalandırma ile tek bir sure görüntülemek için',
  'individual_surah_options':
      'İhtiyaçlarınıza göre sure görüntüleme için birçok seçeneği özelleştirebilirsiniz.',

  // Utils
  'utils_enhanced_description': 'Paket şu gibi birçok yardımcı araç sağlar:',
  'getting_all_quran_data':
      'Tüm Kuran Cüzlerini, Hizblerini ve Surelerini alma',
  'navigation_jumping_enhanced':
      'sayfalar, Sureler veya Hizblar arasında geçiş yapmak için şunları kullanabilirsiniz:',
  'bookmarks_enhanced':
      'Yer imlerini ekleme, ayarlama, kaldırma, alma ve gezinme:',
  'search_enhanced': 'herhangi bir ayeti arama',

  // Fonts Download
  'fonts_download_enhanced':
      'Kuran fontlarını indirmek için iki seçeneğiniz vardır:',
  'fonts_option_1':
      'Varsayılan diyalogu kullanarak, içindeki stili değiştirebilirsiniz.',
  'fonts_option_2':
      'Veya font indirmek için tüm fonksiyonları kullanarak kendi tasarımınızı oluşturabilirsiniz.',
  'macos_requirements':
      'macOS, ağa erişim için özel bir yetki talep etmenizi gerektirir.',
  'macos_instructions':
      'Bunu yapmak için: macos/Runner/DebugProfile.entitlements dosyasını açın ve aşağıdaki anahtar-değer çiftini ekleyin.',
  'fonts_methods_available': 'Font yönetimi için mevcut yöntemler:',

  // Tafsir
  'tafsir_enhanced':
      'Kullanmaya başlamadan önce önemli not: Lütfen bu kütüphaneyi sadece Android için pubspec.yaml dosyanıza ekleyin:',
  'tafsir_note': 'tefsir gösterilirken herhangi bir sorunu önlemek için',
  'tafsir_init': 'Tefsiri başlat',
  'tafsir_usage_example': 'Kullanım Örneği',
  'tafsir_methods': 'Mevcut Tefsir Yöntemleri:',

  // Audio Playback
  'audio_enhanced_description':
      'Bu bölüm, arka plan oynatma desteği ve gelişmiş ses dosyası yönetimi ile Kutsal Kuran\'ın ses oynatması için kapsamlı yetenekler sağlar.',
  'verse_audio_playback': 'Ayet Ses Oynatma',
  'verse_audio_control_note':
      'Tüm bu fonksiyonlar ayet düzeyinde kapsamlı ses kontrolü sağlar.',
  'surah_audio_playback': 'Sure Ses Oynatma',
  'surah_audio_control_note':
      'Bu fonksiyonlar sure düzeyinde tam ses yönetimi sağlar.',
  'download_management': 'İndirme Yönetimi',
  'position_control_resume': 'Pozisyon Kontrolü ve Devam',
  'complete_audio_example': 'Tam Ses Örneği',
  'audio_features_summary': 'Ses Özellikleri Özeti:',
  'audio_feature_verse': '✅ Ayet Oynatma',
  'audio_feature_surah': '✅ Tam Sure Oynatma',
  'audio_feature_navigation': '✅ Navigasyon Kontrolleri',
  'audio_feature_offline': '✅ Çevrimdışı İndirme',
  'audio_feature_resume': '✅ Devam Etme İşlevi',
  'audio_feature_background': '✅ Arka Plan Oynatma',
  'audio_feature_tracking': '✅ Pozisyon İzleme',
  'audio_feature_management': '✅ İndirme Yönetimi',

  // Font Styles
  'font_styles':
      'Varsayılan Kuran fontunu veya Naskh fontunu da kullanabilirsiniz:',
  'hafs_style':
      'hafsStyle, Kuran için varsayılan stildir, böylece tüm özel karakterler doğru şekilde işlenir',
  'naskh_style': 'naskhStyle, diğer metinler için varsayılan stildir.',
  'theming': 'Temalama',
  'fonts_typography': 'Yazı Tipleri ve Tipografi',
  'colors_appearance': 'Renkler ve Görünüm',

  'api_reference': 'API Referansı',
  'core_classes': 'Temel Sınıflar',
  'widget_catalog': 'Widget Kataloğu',
  'configuration_options': 'Yapılandırma Seçenekleri',

  // Content
  'library_description':
      'Kuran Kütüphanesi, Kutsal Kuran\'ı görüntülemek için kapsamlı ve geliştirilmiş bir Flutter kütüphanesidir. Bu kütüphane, Hesham Erfan\'ın flutter_quran\'ının devamı olup birçok yeni ve geliştirilmiş özellik içerir.',

  'library_subtitle': 'Flutter için Kapsamlı Kuran Kütüphanesi',

  'library_features':
      'Kütüphane, özel yazı tipleri ile Kuran görüntüleme, ayet arama, yer imleri, tefsir ve çeviriler gibi kullanımı kolay arayüz ve gelişmiş özellikler sunar.',

  'motivation_text_1':
      'Modern uygulamalar nadiren Kullanıcı Arayüzlerini oluşturmak için gerekli tüm bilgilerle birlikte gelir. Bunun yerine, veriler genellikle bir sunucudan asenkron olarak getirilir.',

  'motivation_text_2':
      'Sorun şu ki, asenkron kod ile çalışmak zordur. Flutter durum değişkenleri oluşturma ve değişiklik üzerine UI\'yi yenileme konusunda bazı yollar sunsa da, hala bazı temel ayrıntılarda başarısız olur.',

  'motivation_goal':
      'Amacımız, etkili durum yönetimi ve güzel kullanıcı arayüzü ile Flutter uygulamalarında Kutsal Kuran\'ı görüntülemek için kapsamlı ve kullanımı kolay bir kütüphane sağlamaktır.',

  'installation_instruction':
      'Flutter projenizin pubspec.yaml dosyasında, aşağıdaki bağımlılığı ekleyin:',
  'run_command': 'Paketleri almak için aşağıdaki komutu çalıştırın:',
  'import_instruction': 'Dart dosyanızda kütüphaneyi içe aktarın:',

  'initialization_instruction':
      'Kütüphaneyi kullanmadan önce, önce başlatmanız gerekir:',

  'first_example_instruction':
      'Uygulamanıza kolayca bir Kuran ekranı ekleyebilirsiniz:',
  'first_example_result':
      'İşte bu kadar! Tüm özelliklerle eksiksiz bir Kuran ekranı elde edeceksiniz.',

  // Features
  'main_features': 'Ana Özellikler',
  'feature_1': 'Güzel fontlarla eksiksiz Kuran görüntüleme',
  'feature_2': 'Ayetler ve surelerde hızlı arama',
  'feature_3': 'Gelişmiş yer imi sistemi',
  'feature_4': 'Tefsir ve farklı çevirilere destek',
  'feature_5': 'Özelleştirilebilir kullanıcı arayüzü',
  'feature_6': 'Tüm cihazlarda çalışan duyarlı tasarım',
  'feature_7': 'Çok dil desteği',
  'feature_8': 'Yüksek performans ve hızlı gezinme',

  // Notes and warnings
  'important_note': 'Önemli Not',
  'warning': 'Uyarı',
  'material3_note':
      'Kütüphanenin doğru çalışması için ThemeData\'da useMaterial3: false ayarladığınızdan emin olun.',
  'android_warning':
      'Tefsir özelliğini etkinleştirmek için Android için drift_flutter eklemeniz gerekir.',

  'copied': 'Kopyalandı!',
  'copy': 'Kopyala',

  // Search
  'search_documentation': 'Dokümantasyonda ara',
  'search_results': 'Arama Sonuçları',
  'results': 'sonuç',
  'no_results': 'Sonuç bulunamadı',

  // Motivation section
  'motivation_description':
      'Kuran Kütüphanesi, Flutter uygulamalarında Kutsal Kuran\'ı görüntülemek için kapsamlı ve entegre bir çözüm sağlamak üzere geliştirilmiştir. Bu kütüphane, yüksek kaliteli İslami uygulamalar oluşturmak isteyen geliştiricilerin ihtiyaçlarını karşılar.',
  'key_benefits': 'Ana Avantajlar',
  'benefit_performance': 'Yüksek performans ve düzgün görüntüleme',
  'benefit_arabic_optimization':
      'Arapça metinler ve İslami fontlar için özel optimizasyon',
  'benefit_comprehensive_features':
      'Okuma, arama ve gezinme için kapsamlı özellikler',
  'benefit_audio_support': 'Ses tilaveti için tam destek',
  'benefit_offline_capability':
      'İnternet bağlantısı olmadan çevrimdışı yetenek',
  'motivation_note':
      'Bu kütüphane, yeni başlayan geliştiriciler için kullanımı kolay ve deneyimli geliştiriciler için yeterince esnek olacak şekilde tasarlanmıştır.',

  // First Example section
  'first_example_description':
      'Bu, Kuran Kütüphanesi\'ni kullanmanın en basit örneğidir. Tüm Kuran surelerinin basit bir listesini nasıl oluşturacağınızı ve aralarında nasıl gezineceğinizi gösterir.',
  'example_note':
      'Bu örnek, kütüphanenin temel kullanımını göstermektedir. Uygulamanızın ihtiyaçlarına göre tasarım ve özellikleri özelleştirebilirsiniz.',

  // Basic Quran Screen section
  'basic_screen_description': 'veya bazı seçenekler verin:',
  'basic_screen_note':
      'Uygulama ihtiyaçlarınıza göre birçok seçeneği özelleştirebilirsiniz.',

  // Individual Surah Display section
  'individual_surah_description':
      'Özel sayfalandırma ile tek bir sure görüntülemek için:',
  'individual_surah_note':
      'İhtiyaçlarınıza göre sure görüntüleme için birçok seçeneği özelleştirebilirsiniz.',

  // Utility Functions section
  'utility_functions_description': 'Paket şu gibi birçok yardımcı araç sağlar:',
  'getting_quran_data': 'Tüm Kuran Cüzlerini, Hizblerini ve Surelerini alma',
  'navigation_jumping_utils':
      'sayfalar, Sureler veya Hizblar arasında geçiş yapmak için şunları kullanabilirsiniz',
  'bookmarks_management':
      'Yer imlerini ekleme, ayarlama, kaldırma, alma ve gezinme',
  'search_functionality_utils': 'herhangi bir ayeti arama',
  'utility_functions_note':
      'Tüm bu yardımcı araçlar, geliştirmeyi kolaylaştırmak için Kuran Kütüphanesi\'nde mevcuttur.',

  // Missing keys added for Turkish
  'download_fonts_description': 'لتحميل خطوط المصحف لديك خيارين: أما استخدام نافذة الحوار الافتراضية ويمكنك تعديل الخصائص التي فيها، أو يمكنك عمل تصميم خاص بك مع استخدام جميع الدوال الخاصة بتحميل الخطوط.', // TODO: Translate to Turkish
  'download_options': 'خيارات التحميل', // TODO: Translate to Turkish
  'download_options_description': 'يمكنك استخدام الحوار الافتراضي أو إنشاء تصميم مخصص.', // TODO: Translate to Turkish
  'macos_note': 'ملاحظة مهمة لـ macOS', // TODO: Translate to Turkish
  'macos_warning_text': 'تحتاج MACOS إلى طلب استحقاق محدد للوصول إلى الشبكة. للقيام بذلك: افتح MacOS/Runner/DebugProfile.Entitlements وأضف زوج القيمة والمفتاح المطلوب.', // TODO: Translate to Turkish
  'fonts_download_dialog': 'حوار تحميل الخطوط', // TODO: Translate to Turkish
  'fonts_download_widget': 'ودجت تحميل الخطوط', // TODO: Translate to Turkish
  'fonts_methods': 'طرق التحكم في الخطوط', // TODO: Translate to Turkish
  'fonts_download_note': 'جميع هذه الطرق متوفرة لإدارة تحميل واستخدام خطوط المصحف.', // TODO: Translate to Turkish
};
