import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class BookmarkSection extends BaseSectionPage {
  const BookmarkSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('utility_functions'),
        const Gap(16),
        buildSubtitle('bookmarks_enhanced'),
        const Gap(12),
        CodeBlock(
          language: 'dart',
          code: '''// In init function
QuranLibrary().init(userBookmarks: [Bookmark(id: 0, colorCode: Colors.red.value, name: "Red Bookmark")]);
final usedBookmarks = QuranLibrary().getUsedBookmarks();
QuranLibrary().setBookmark(surahName: 'الفاتحة', ayahNumber: 5, ayahId: 5, page: 1, bookmarkId: 0);
QuranLibrary().removeBookmark(bookmarkId: 0);
QuranLibrary().jumpToBookmark(BookmarkModel bookmark);''',
        ),
      ],
    );
  }
}
