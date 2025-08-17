import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_theme.dart';
import '../controllers/search_controller.dart';

class SearchWidget extends StatelessWidget {
  final bool isMobile;

  const SearchWidget({super.key, required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return _buildSearchIcon(context);
  }

  Widget _buildSearchIcon(BuildContext context) {
    return Tooltip(
      message: 'search'.tr,
      child: InkWell(
        onTap: () => _showSearchDialog(context),
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.search,
            color: AppTheme.textSecondary,
            size: 20,
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    final searchController = Get.find<AppSearchController>();

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        alignment: Alignment.topCenter,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        insetPadding: EdgeInsets.only(
          top: 100,
          left: isMobile ? 20 : MediaQuery.of(context).size.width * 0.25,
          right: isMobile ? 20 : MediaQuery.of(context).size.width * 0.25,
        ),
        child: Container(
          constraints: const BoxConstraints(maxHeight: 400, minHeight: 40),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Search input
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.cardColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.primaryBlue.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Icon(Icons.search, size: 20),
                        ),
                        Expanded(
                          child: TextFormField(
                            controller: searchController.textController,
                            onChanged: searchController.performSearch,
                            style: GoogleFonts.cairo(fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'search_documentation'.tr,
                              border: InputBorder.none,
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12),
                            ),
                            autofocus: true,
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close, size: 20),
                        ),
                      ],
                    ),
                  ),
                  if (searchController.searchResults.isEmpty) const Gap(16),
                  // Search results
                  Obx(() {
                    if (searchController.searchResults.isEmpty) {
                      if (searchController.searchQuery.value.isNotEmpty) {
                        return Text(
                          'no_results'.tr,
                          style: GoogleFonts.cairo(
                            color: AppTheme.textSecondary,
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }

                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: searchController.searchResults.length,
                        itemBuilder: (context, index) {
                          final result = searchController.searchResults[index];
                          return InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                              searchController.navigateToResult(
                                  result, context);
                            },
                            borderRadius: BorderRadius.circular(8),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.description,
                                    color: AppTheme.primaryBlue,
                                    size: 18,
                                  ),
                                  const Gap(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          result.item.titleKey.tr,
                                          style: GoogleFonts.cairo(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        if (result
                                            .matchedKeywords.isNotEmpty) ...[
                                          const Gap(4),
                                          Text(
                                            result.matchedKeywords
                                                .take(2)
                                                .join(', '),
                                            style: GoogleFonts.cairo(
                                              fontSize: 12,
                                              color: AppTheme.textSecondary,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                    color: AppTheme.textSecondary,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    ).then((_) {
      searchController.clearSearch();
    });
  }
}
