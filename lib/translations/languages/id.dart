const Map<String, String> id = {
  // Header
  'app_title': 'Perpustakaan Quran',
  'app_subtitle': 'مكتبة القرآن',
  'docs': 'Dokumentasi',
  'search': 'Pencarian',

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
  'documentation': 'Dokumentasi',
  'comprehensive_guide': 'Panduan lengkap menggunakan Quran Library',

  // Main sections
  'getting_started': 'Memulai',
  'usage_examples': 'Contoh Penggunaan',
  'utils': 'Utilitas',
  'fonts_download': 'Unduh Font',
  'tafsir': 'Tafsir',
  'audio_playback': 'Pemutaran Audio',

  // Getting Started subsections
  'what_is_quran_library': 'Apa itu Quran Library?',
  'motivation_behind_library': 'Motivasi di balik library',
  'installation': 'Instalasi',
  'initial_setup': 'Setup Awal',

  // Usage Examples subsections
  'first_example': 'Contoh Pertama',
  'basic_quran_screen': 'Layar Quran Dasar',
  'individual_surah_display': 'Tampilan Surah Individual',

  // Utils subsections
  'utility_functions': 'Fungsi Utilitas',
  'navigation_jumping': 'Navigasi dan Jumping',
  'bookmarks': 'Bookmark',
  'quran_search': 'Pencarian Quran',

  // Fonts Download subsections
  'download_quran_fonts': 'Unduh Font Quran',

  // Tafsir subsections
  'tafsir_initialization': 'Inisialisasi Tafsir',

  // Audio Playback subsections
  'audio_verse_playback': 'Pemutaran Audio Ayat',
  'audio_surah_playback': 'Pemutaran Audio Surah',
  'audio_download_management': 'Manajemen Unduhan',
  'audio_position_control': 'Kontrol Posisi & Lanjutkan',

  // Old sections for compatibility
  'introduction': 'Pengantar',
  'quick_start': 'Mulai Cepat',
  'options_customization': 'Opsi dan Kustomisasi',
  'advanced_features': 'Fitur Lanjutan',
  'search_functionality': 'Fungsi Pencarian',
  'tafsir_integration': 'Integrasi Tafsir',
  'custom_themes': 'Tema Kustom',
  'customization': 'Kustomisasi',

  // Installation section
  'permissions': 'Izin',
  'permissions_subtitle': 'Izin',
  'android_permissions': 'Android',
  'android_permissions_description':
      'Izin yang diperlukan untuk pemutaran audio (WAKE_LOCK, FOREGROUND_SERVICE, dan FOREGROUND_SERVICE_MEDIA_PLAYBACK) ditambahkan secara otomatis oleh paket. Anda tidak perlu mengedit AndroidManifest.xml secara manual.',
  'ios_permissions': 'iOS',
  'ios_permissions_description':
      'Untuk pemutaran audio latar belakang, Anda harus menambahkan yang berikut ke Info.plist aplikasi Anda:',
  'ios_permissions_note':
      'Ini memungkinkan pemutaran audio terus berlanjut saat aplikasi berada di latar belakang.',
  'initialize_library': 'Inisialisasi Library',

  // Basic Quran Screen
  'basic_quran_simple': 'Anda dapat menambahkannya ke kode Anda seperti ini:',
  'advanced_options': 'Opsi Lanjutan',
  'advanced_options_description': 'Atau berikan beberapa opsi:',

  // Individual Surah Display
  'individual_surah_enhanced':
      'Untuk menampilkan surah tunggal dengan paginasi kustom',
  'individual_surah_options':
      'Anda dapat menyesuaikan banyak opsi untuk tampilan surah sesuai kebutuhan Anda.',

  // Utils
  'utils_enhanced_description':
      'Paket ini menyediakan banyak utilitas seperti:',
  'getting_all_quran_data': 'Mendapatkan semua Juz, Hizb, dan Surah Quran',
  'navigation_jumping_enhanced':
      'untuk melompat antara halaman, Surah atau Hizb Anda dapat menggunakan:',
  'bookmarks_enhanced':
      'Menambah, mengatur, menghapus, mendapatkan dan menavigasi bookmark:',
  'search_enhanced': 'mencari ayat apapun',

  // Fonts Download
  'fonts_download_enhanced':
      'Untuk mengunduh font Quran, Anda memiliki dua opsi:',
  'fonts_option_1':
      'Menggunakan dialog default, Anda dapat memodifikasi gaya di dalamnya.',
  'fonts_option_2':
      'Atau Anda dapat membuat desain sendiri menggunakan semua fungsi untuk mengunduh font.',
  'macos_requirements':
      'macOS memerlukan Anda untuk meminta entitlement khusus untuk mengakses jaringan.',
  'macos_instructions':
      'Untuk melakukan itu: buka macos/Runner/DebugProfile.entitlements dan tambahkan pasangan key-value berikut.',
  'fonts_methods_available': 'Metode yang tersedia untuk manajemen font:',

  // Tafsir
  'tafsir_enhanced':
      'Catatan penting sebelum mulai menggunakan: Silakan tambahkan library ini ke file pubspec.yaml Anda hanya untuk Android:',
  'tafsir_note': 'untuk menghindari masalah saat menampilkan tafsir',
  'tafsir_init': 'Inisialisasi tafsir',
  'tafsir_usage_example': 'Contoh Penggunaan',
  'tafsir_methods': 'Metode Tafsir yang Tersedia:',

  // Audio Playback
  'audio_enhanced_description':
      'Bagian ini menyediakan kemampuan komprehensif untuk pemutaran audio Al-Quran dengan dukungan pemutaran latar belakang dan manajemen file audio lanjutan.',
  'verse_audio_playback': 'Pemutaran Audio Ayat',
  'verse_audio_control_note':
      'Semua fungsi ini menyediakan kontrol audio tingkat ayat yang komprehensif.',
  'surah_audio_playback': 'Pemutaran Audio Surah',
  'surah_audio_control_note':
      'Fungsi-fungsi ini menyediakan manajemen audio tingkat surah yang lengkap.',
  'download_management': 'Manajemen Unduhan',
  'position_control_resume': 'Kontrol Posisi & Lanjutkan',
  'complete_audio_example': 'Contoh Audio Lengkap',
  'audio_features_summary': 'Ringkasan Fitur Audio:',
  'audio_feature_verse': '✅ Pemutaran Ayat',
  'audio_feature_surah': '✅ Pemutaran Surah Lengkap',
  'audio_feature_navigation': '✅ Kontrol Navigasi',
  'audio_feature_offline': '✅ Unduhan Offline',
  'audio_feature_resume': '✅ Fungsi Lanjutkan',
  'audio_feature_background': '✅ Pemutaran Latar Belakang',
  'audio_feature_tracking': '✅ Pelacakan Posisi',
  'audio_feature_management': '✅ Manajemen Unduhan',

  // Font Styles
  'font_styles':
      'Anda juga dapat menggunakan font Quran default atau font Naskh:',
  'hafs_style':
      'hafsStyle adalah gaya default untuk Quran sehingga semua karakter khusus akan dirender dengan benar',
  'naskh_style': 'naskhStyle adalah gaya default untuk teks lain.',
  'theming': 'Tema',
  'fonts_typography': 'Font dan Tipografi',
  'colors_appearance': 'Warna dan Tampilan',

  'api_reference': 'Referensi API',
  'core_classes': 'Kelas Inti',
  'widget_catalog': 'Katalog Widget',
  'configuration_options': 'Opsi Konfigurasi',

  // Content
  'library_description':
      'Quran Library adalah library Flutter yang komprehensif dan dikembangkan untuk menampilkan Al-Quran. Library ini merupakan kelanjutan dari flutter_quran oleh Hesham Erfan dengan banyak fitur baru dan yang ditingkatkan.',

  'library_subtitle': 'Library Quran Komprehensif untuk Flutter',

  'library_features':
      'Library ini memiliki antarmuka yang mudah digunakan dan fitur canggih seperti menampilkan Quran dengan font kustom, pencarian ayat, bookmark, tafsir, dan terjemahan.',

  'motivation_text_1':
      'Aplikasi modern jarang dilengkapi dengan semua informasi yang diperlukan untuk merender Antarmuka Pengguna mereka. Sebaliknya, data sering diambil secara asinkron dari server.',

  'motivation_text_2':
      'Masalahnya adalah, bekerja dengan kode asinkron itu sulit. Meskipun Flutter hadir dengan beberapa cara untuk membuat variabel state dan menyegarkan UI saat ada perubahan, namun masih gagal pada beberapa detail mendasar.',

  'motivation_goal':
      'Tujuan kami adalah menyediakan library yang komprehensif dan mudah digunakan untuk menampilkan Al-Quran dalam aplikasi Flutter dengan manajemen state yang efisien dan antarmuka pengguna yang indah.',

  'installation_instruction':
      'Dalam file pubspec.yaml proyek Flutter Anda, tambahkan dependensi berikut:',
  'run_command': 'Jalankan perintah berikut untuk mendapatkan package:',
  'import_instruction': 'Import library di file Dart Anda:',

  'initialization_instruction':
      'Sebelum menggunakan library, Anda harus menginisialisasinya terlebih dahulu:',

  'first_example_instruction':
      'Anda dapat dengan mudah menambahkan layar Quran ke aplikasi Anda sebagai berikut:',
  'first_example_result':
      'Itu saja! Anda akan mendapatkan layar Quran lengkap dengan semua fitur.',

  // Features
  'main_features': 'Fitur Utama',
  'feature_1': 'Tampilan Quran lengkap dengan font yang indah',
  'feature_2': 'Pencarian cepat dalam ayat dan surah',
  'feature_3': 'Sistem bookmark canggih',
  'feature_4': 'Dukungan untuk tafsir dan terjemahan berbeda',
  'feature_5': 'Antarmuka pengguna yang dapat disesuaikan',
  'feature_6': 'Desain responsif yang berfungsi di semua perangkat',
  'feature_7': 'Dukungan multi-bahasa',
  'feature_8': 'Performa tinggi dan navigasi cepat',

  // Notes and warnings
  'important_note': 'Catatan Penting',
  'warning': 'Peringatan',
  'material3_note':
      'Pastikan untuk mengatur useMaterial3: false di ThemeData agar library berfungsi dengan benar.',
  'android_warning':
      'Anda harus menambahkan drift_flutter untuk Android untuk mengaktifkan fitur tafsir.',

  'copied': 'Disalin!',
  'copy': 'Salin',

  // Search
  'search_documentation': 'Cari dokumentasi',
  'search_results': 'Hasil Pencarian',
  'results': 'hasil',
  'no_results': 'Tidak ada hasil ditemukan',

  // Motivation section
  'motivation_description':
      'Quran Library dikembangkan untuk menyediakan solusi komprehensif dan terintegrasi untuk menampilkan Al-Quran dalam aplikasi Flutter. Library ini memenuhi kebutuhan developer yang ingin membuat aplikasi Islam berkualitas tinggi.',
  'key_benefits': 'Manfaat Utama',
  'benefit_performance': 'Performa tinggi dan tampilan yang lancar',
  'benefit_arabic_optimization':
      'Optimasi khusus untuk teks Arab dan font Islam',
  'benefit_comprehensive_features':
      'Fitur komprehensif untuk membaca, mencari, dan navigasi',
  'benefit_audio_support': 'Dukungan penuh untuk bacaan audio',
  'benefit_offline_capability': 'Kemampuan offline tanpa koneksi internet',
  'motivation_note':
      'Library ini dirancang untuk mudah digunakan bagi developer pemula dan cukup fleksibel untuk developer berpengalaman.',

  // First Example section
  'first_example_description':
      'Ini adalah contoh paling sederhana menggunakan Quran Library. Menunjukkan cara membuat daftar sederhana dari semua surah Al-Quran dengan kemampuan navigasi di antara mereka.',
  'example_note':
      'Contoh ini mendemonstrasikan penggunaan dasar library. Anda dapat menyesuaikan desain dan fitur sesuai kebutuhan aplikasi Anda.',

  // Basic Quran Screen section
  'basic_screen_description': 'atau berikan beberapa opsi:',
  'basic_screen_note':
      'Anda dapat menyesuaikan banyak opsi sesuai kebutuhan aplikasi Anda.',

  // Individual Surah Display section
  'individual_surah_description':
      'Untuk menampilkan satu surah dengan paginasi kustom:',
  'individual_surah_note':
      'Anda dapat menyesuaikan banyak opsi untuk tampilan surah sesuai kebutuhan Anda.',

  // Utility Functions section
  'utility_functions_description':
      'Paket ini menyediakan banyak utilitas seperti:',
  'getting_quran_data': 'Mendapatkan semua Juz, Hizb, dan Surah Al-Quran',
  'navigation_jumping_utils':
      'untuk berpindah antar halaman, Surah atau Hizb Anda dapat menggunakan',
  'bookmarks_management':
      'Menambahkan, mengatur, menghapus, mendapatkan dan menavigasi bookmark',
  'search_functionality_utils': 'mencari ayat apa pun',
  'utility_functions_note':
      'Semua utilitas ini tersedia di Quran Library untuk memudahkan pengembangan.',

  // Missing keys added for Indonesian
  'download_fonts_description': 'لتحميل خطوط المصحف لديك خيارين: أما استخدام نافذة الحوار الافتراضية ويمكنك تعديل الخصائص التي فيها، أو يمكنك عمل تصميم خاص بك مع استخدام جميع الدوال الخاصة بتحميل الخطوط.', // TODO: Translate to Indonesian
  'download_options': 'خيارات التحميل', // TODO: Translate to Indonesian
  'download_options_description': 'يمكنك استخدام الحوار الافتراضي أو إنشاء تصميم مخصص.', // TODO: Translate to Indonesian
  'macos_note': 'ملاحظة مهمة لـ macOS', // TODO: Translate to Indonesian
  'macos_warning_text': 'تحتاج MACOS إلى طلب استحقاق محدد للوصول إلى الشبكة. للقيام بذلك: افتح MacOS/Runner/DebugProfile.Entitlements وأضف زوج القيمة والمفتاح المطلوب.', // TODO: Translate to Indonesian
  'fonts_download_dialog': 'حوار تحميل الخطوط', // TODO: Translate to Indonesian
  'fonts_download_widget': 'ودجت تحميل الخطوط', // TODO: Translate to Indonesian
  'fonts_methods': 'طرق التحكم في الخطوط', // TODO: Translate to Indonesian
  'fonts_download_note': 'جميع هذه الطرق متوفرة لإدارة تحميل واستخدام خطوط المصحف.', // TODO: Translate to Indonesian
};
