import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../widgets/code_block.dart';
import 'base_section_page.dart';

class NavigationJumpingSection extends BaseSectionPage {
  const NavigationJumpingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildTitle('utility_functions'),
        const Gap(16),
        buildSubtitle('navigation_jumping_enhanced'),
        const Gap(16),
        CodeBlock(
          language: 'dart',
          code: '''/// [navigateToAyah] يتيح لك التنقل إلى أي آية.
/// من الأفضل استدعاء هذه الطريقة أثناء عرض شاشة القرآن،
/// وإذا تم استدعاؤها ولم تكن شاشة القرآن معروضة،
/// فسيتم بدء العرض من صفحة هذه الآية عند فتح شاشة القرآن في المرة التالية.
///
/// [jumpToAyah] let's you navigate to any ayah..
/// It's better to call this method while Quran screen is displayed
/// and if it's called and the Quran screen is not displayed, the next time you
/// open quran screen it will start from this ayah's page
QuranLibrary().jumpToAyah(AyahModel ayah);
/// أو يمكنك استخدام:
/// or you can use:
/// jumpToPage, jumpToJoz, jumpToHizb, jumpToBookmark and jumpToSurah.''',
        ),
      ],
    );
  }
}
