import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/content/content_models.dart';
import '../core/content/content_repository.dart';
import 'content_controller.dart';

class AdminController extends GetxController {
  static AdminController get instance => Get.find();

  final Rxn<SiteContent> working = Rxn<SiteContent>();
  final RxString selectedSectionId = ''.obs;
  final RxInt selectedBlockIndex = (-1).obs;

  List<String> get languages => working.value?.languages ?? const [];
  String get defaultLang => working.value?.defaultLanguage ?? 'ar';

  // اللغات المطلوبة في المنصة (يجب مزامنتها مع الملف JSON الأساسي)
  static const List<String> requiredLanguages = [
    'ar',
    'en',
    'bn',
    'id',
    'ur',
    'tr',
    'ku',
    'ms',
    'es'
  ];

  @override
  void onInit() {
    super.onInit();
    loadFromAppContent();
  }

  void loadFromAppContent() {
    final app = ContentController.instance.content;
    if (app == null) return;
    // Deep copy via JSON
    final cloned = SiteContent.tryParse(jsonEncode(app.toJson()));
    working.value = cloned;
    if (cloned != null) {
      _ensureAllLanguages(cloned);
    }
    // Select first section if none
    if ((selectedSectionId.value.isEmpty) && cloned != null) {
      if (cloned.sectionsById.isNotEmpty) {
        final first = (cloned.sectionsById.values.toList()
              ..sort((a, b) => a.order.compareTo(b.order)))
            .first;
        selectedSectionId.value = first.id;
      }
    }
  }

  SiteContent? get content => working.value;
  SectionModel? get selectedSection =>
      content?.sectionsById[selectedSectionId.value];

  void selectSection(String id) {
    selectedSectionId.value = id;
    selectedBlockIndex.value = -1;
  }

  void changeSectionGroup(String sectionId, String newGroupId) {
    final c = content;
    if (c == null) return;
    // Remove from any group
    for (final g in c.groups) {
      g.sectionIds.remove(sectionId);
    }
    // Add to target group
    final target = c.groups.firstWhereOrNull((g) => g.id == newGroupId);
    target?.sectionIds.add(sectionId);
    working.refresh();
  }

  String? getGroupOf(String sectionId) {
    final c = content;
    if (c == null) return null;
    for (final g in c.groups) {
      if (g.sectionIds.contains(sectionId)) return g.id;
    }
    return null;
  }

  void moveSectionInGroup(String groupId, int delta) {
    final c = content;
    final sId = selectedSectionId.value;
    if (c == null || sId.isEmpty) return;
    final g = c.groups.firstWhereOrNull((x) => x.id == groupId);
    if (g == null) return;
    final idx = g.sectionIds.indexOf(sId);
    if (idx == -1) return;
    var newIdx = idx + delta;
    if (newIdx < 0 || newIdx >= g.sectionIds.length) return;
    final id = g.sectionIds.removeAt(idx);
    g.sectionIds.insert(newIdx, id);
    working.refresh();
  }

  void updateSectionKeywords(List<String> keywords) {
    final c = content;
    final s = selectedSection;
    if (c == null || s == null) return;
    final updated = SectionModel(
      id: s.id,
      title: s.title,
      order: s.order,
      keywords: keywords,
      blocks: s.blocks,
      children: s.children,
    );
    c.sectionsById[s.id] = updated;
    working.refresh();
  }

  void setSectionTitle(String lang, String value) {
    final s = selectedSection;
    if (s == null) return;
    try {
      s.title.map[lang] = value;
    } catch (e) {
      // إذا كان title.map غير قابل للتعديل، نُنشئ نسخة جديدة
      final newTitle = LocalizedText(Map<String, String>.from(s.title.map));
      newTitle.map[lang] = value;
      content!.sectionsById[s.id] = SectionModel(
        id: s.id,
        order: s.order,
        title: newTitle,
        keywords: s.keywords,
        blocks: s.blocks,
        children: s.children,
      );
      selectedSectionId.value = s.id;
    }
    working.refresh();
  }

  void addSection(String groupId, SectionModel section) {
    final c = content;
    if (c == null) return;
    c.sectionsById[section.id] = section;
    final g = c.groups.firstWhereOrNull((x) => x.id == groupId);
    g?.sectionIds.add(section.id);
    selectedSectionId.value = section.id;
    working.refresh();
  }

  // إضافة قسم مستقل - ينشئ مجموعة جديدة تحمل نفس اسم القسم
  void addStandaloneSection(SectionModel section) {
    final c = content;
    if (c == null) return;

    // إنشاء مجموعة جديدة للقسم المستقل
    final newGroup = GroupModel(
      id: '${section.id}_group',
      title: section.title, // نفس عنوان القسم
      order: c.groups.length,
      sectionIds: [section.id],
    );

    c.sectionsById[section.id] = section;
    c.groups.add(newGroup);
    selectedSectionId.value = section.id;
    working.refresh();
  }

  // إدارة الأقسام الفرعية
  void addChildSection(String parentId, String childId) {
    final c = content;
    if (c == null) return;
    final parent = c.sectionsById[parentId];
    if (parent == null) return;
    if (!parent.children.contains(childId)) {
      parent.children.add(childId);
      working.refresh();
    }
  }

  void removeChildSection(String parentId, String childId) {
    final c = content;
    if (c == null) return;
    final parent = c.sectionsById[parentId];
    if (parent == null) return;
    parent.children.remove(childId);
    working.refresh();
  }

  void moveChildSection(String parentId, int oldIndex, int newIndex) {
    final c = content;
    if (c == null) return;
    final parent = c.sectionsById[parentId];
    if (parent == null) return;
    if (newIndex > oldIndex) newIndex -= 1;
    if (oldIndex < 0 || oldIndex >= parent.children.length) return;
    if (newIndex < 0 || newIndex >= parent.children.length) return;
    final id = parent.children.removeAt(oldIndex);
    parent.children.insert(newIndex, id);
    working.refresh();
  }

  void deleteSection(String id) {
    final c = content;
    if (c == null) return;
    // إزالة من أي children للأقسام الأخرى
    for (final s in c.sectionsById.values) {
      s.children.remove(id);
    }
    c.sectionsById.remove(id);
    for (final g in c.groups) {
      g.sectionIds.remove(id);
    }
    if (selectedSectionId.value == id) {
      selectedSectionId.value = '';
      if (c.sectionsById.isNotEmpty) {
        selectedSectionId.value = c.sectionsById.values.first.id;
      }
    }
    working.refresh();
  }

  // تحديث ID القسم مع التحقق من التكرار
  void updateSectionId(String oldId, String newId) {
    final c = content;
    if (c == null || oldId == newId) return;

    // التحقق من عدم وجود القسم الجديد مسبقاً
    if (c.sectionsById.containsKey(newId)) {
      Get.snackbar(
        'خطأ',
        'القسم بـ ID: $newId موجود بالفعل',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFFDC3545),
        colorText: const Color(0xFFFFFFFF),
      );
      return;
    }

    // نسخ القسم القديم
    final oldSection = c.sectionsById[oldId];
    if (oldSection == null) return;

    // إنشاء قسم جديد بنفس البيانات مع ID جديد
    final newSection = SectionModel(
      id: newId,
      title: oldSection.title,
      order: oldSection.order,
      keywords: oldSection.keywords,
      blocks: oldSection.blocks,
      children: oldSection.children,
    );

    // استبدال القسم في sectionsById
    c.sectionsById.remove(oldId);
    c.sectionsById[newId] = newSection;

    // تحديث المراجع في المجموعات
    for (final g in c.groups) {
      final index = g.sectionIds.indexOf(oldId);
      if (index != -1) {
        g.sectionIds[index] = newId;
      }
    }

    // تحديث المراجع في children للأقسام الأخرى
    for (final s in c.sectionsById.values) {
      final index = s.children.indexOf(oldId);
      if (index != -1) {
        s.children[index] = newId;
      }
    }

    // تحديث القسم المختار
    if (selectedSectionId.value == oldId) {
      selectedSectionId.value = newId;
    }

    working.refresh();

    Get.snackbar(
      'تم',
      'تم تحديث ID من "$oldId" إلى "$newId"',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF28A745),
      colorText: const Color(0xFFFFFFFF),
    );
  }

  void addBlock(String type) {
    final s = selectedSection;
    if (s == null) return;
    s.blocks.add(BlockModel(
      type: type,
      content: LocalizedText({for (final l in languages) l: ''}),
      props: {},
    ));
    selectedBlockIndex.value = s.blocks.length - 1;
    working.refresh();
  }

  void removeBlock(int index) {
    final s = selectedSection;
    if (s == null || index < 0 || index >= s.blocks.length) return;
    s.blocks.removeAt(index);
    if (selectedBlockIndex.value == index) {
      selectedBlockIndex.value = -1;
    }
    working.refresh();
  }

  void moveBlock(int oldIndex, int newIndex) {
    final s = selectedSection;
    if (s == null) return;
    if (newIndex > oldIndex) newIndex -= 1;
    final item = s.blocks.removeAt(oldIndex);
    s.blocks.insert(newIndex, item);
    selectedBlockIndex.value = newIndex;
    working.refresh();
  }

  void setBlockContent(int index, String lang, String value) {
    final s = selectedSection;
    if (s == null || index < 0 || index >= s.blocks.length) return;
    try {
      s.blocks[index].content.map[lang] = value;
    } catch (e) {
      // إذا كان content.map غير قابل للتعديل، نُنشئ نسخة جديدة
      final block = s.blocks[index];
      final newContent =
          LocalizedText(Map<String, String>.from(block.content.map));
      newContent.map[lang] = value;
      s.blocks[index] = BlockModel(
        type: block.type,
        content: newContent,
        props: block.props,
      );
    }
    working.refresh();
  }

  void setBlockProp(int index, String key, dynamic value) {
    final s = selectedSection;
    if (s == null || index < 0 || index >= s.blocks.length) return;
    try {
      s.blocks[index].props[key] = value;
    } catch (e) {
      // إذا كان props غير قابل للتعديل، نُنشئ نسخة جديدة
      final block = s.blocks[index];
      final newProps = Map<String, dynamic>.from(block.props);
      newProps[key] = value;
      s.blocks[index] = BlockModel(
        type: block.type,
        content: block.content,
        props: newProps,
      );
    }
    working.refresh();
  }

  // Items for list/feature_list
  void addItem(int index) {
    final s = selectedSection;
    if (s == null || index < 0 || index >= s.blocks.length) return;
    final items = (s.blocks[index].props['items'] as List?) ?? [];
    final map = {for (final l in languages) l: ''};
    items.add(map);
    s.blocks[index].props['items'] = items;
    working.refresh();
  }

  void setItemValue(int index, int itemIndex, String lang, String value) {
    final s = selectedSection;
    if (s == null) return;
    final items = (s.blocks[index].props['items'] as List?) ?? [];
    if (itemIndex < 0 || itemIndex >= items.length) return;
    final map = (items[itemIndex] as Map).cast<String, dynamic>();
    map[lang] = value;
    items[itemIndex] = map;
    s.blocks[index].props['items'] = items;
    working.refresh();
  }

  void removeItem(int index, int itemIndex) {
    final s = selectedSection;
    if (s == null) return;
    final items = (s.blocks[index].props['items'] as List?) ?? [];
    if (itemIndex < 0 || itemIndex >= items.length) return;
    items.removeAt(itemIndex);
    s.blocks[index].props['items'] = items;
    working.refresh();
  }

  Future<void> saveToLocalAndApply() async {
    final c = content;
    if (c == null) return;
    // تأكد من استكمال اللغات قبل الحفظ
    _ensureAllLanguages(c);
    final jsonStr = const JsonEncoder.withIndent('  ').convert(c.toJson());
    await ContentRepository.instance.saveLocalAndApply(jsonStr);
    await ContentController.instance.load();
  }

  // إضافة زر خارجي لاستدعاءه: يضمن وجود جميع اللغات المطلوبة داخل هيكل العمل.
  void ensureAllLanguagesExpose() {
    final c = content;
    if (c == null) return;
    _ensureAllLanguages(c);
    working.refresh();
  }

  void _ensureAllLanguages(SiteContent c) {
    // أضف أي لغة ناقصة في قائمة اللغات
    final missing =
        requiredLanguages.where((l) => !c.languages.contains(l)).toList();
    if (missing.isNotEmpty) {
      c.languages.addAll(missing);
    }
    // مرّ على كل قسم وكل بلوك واملأ القيم الفارغة للغات الجديدة
    for (final section in c.sectionsById.values) {
      for (final lang in c.languages) {
        section.title.map
            .putIfAbsent(lang, () => section.title.map[defaultLang] ?? '');
      }
      for (final block in section.blocks) {
        for (final lang in c.languages) {
          block.content.map
              .putIfAbsent(lang, () => block.content.map[defaultLang] ?? '');
        }
        // لو block من نوع list أو feature_list تأكد من عناصره
        if (block.props.containsKey('items')) {
          final items = (block.props['items'] as List?) ?? [];
          for (int i = 0; i < items.length; i++) {
            final item = (items[i] as Map).cast<String, dynamic>();
            for (final lang in c.languages) {
              item.putIfAbsent(lang, () => item[defaultLang] ?? '');
            }
            items[i] = item;
          }
          block.props['items'] = items;
        }
      }
    }
  }
}
