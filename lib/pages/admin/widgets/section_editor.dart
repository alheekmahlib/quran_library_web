import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_theme.dart';
import '../../../controllers/admin_controller.dart';
import '../../../controllers/language_controller.dart';
import '../../../core/content/content_models.dart';

// دالة مساعدة لتحديد اتجاه النص بناءً على اللغة
TextDirection getTextDirectionForLang(String lang) {
  const rtlLanguages = ['ar', 'ur', 'ku'];
  return rtlLanguages.contains(lang) ? TextDirection.rtl : TextDirection.ltr;
}

class SectionEditor extends StatefulWidget {
  const SectionEditor({super.key});
  @override
  State<SectionEditor> createState() => _SectionEditorState();
}

class _SectionEditorState extends State<SectionEditor> {
  final TextEditingController _keywords = TextEditingController();
  final TextEditingController _sectionId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final admin = AdminController.instance;
    return Obx(() {
      final content = admin.content!;
      final section = admin.selectedSection;
      // Force rebuild when selection or content changes
      admin.selectedSectionId.value;
      admin.working.value;

      if (section == null) {
        return const Center(child: Text('اختر قسمًا من القائمة'));
      }
      _keywords.text = section.keywords.join(', ');
      _sectionId.text = section.id;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _sectionId,
                            style:
                                GoogleFonts.cairo(fontWeight: FontWeight.w700),
                            decoration: const InputDecoration(
                              labelText: 'ID القسم (snake_case)',
                              helperText: 'استخدم الأحرف الصغيرة و _ فقط',
                            ),
                            onSubmitted: (newId) {
                              if (newId.trim().isEmpty || newId == section.id)
                                return;
                              // التحقق من صحة التنسيق
                              if (!RegExp(r'^[a-z][a-z0-9_]*$')
                                  .hasMatch(newId)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'ID يجب أن يكون بصيغة snake_case (أحرف صغيرة و _ فقط)'),
                                  ),
                                );
                                _sectionId.text = section.id;
                                return;
                              }
                              admin.updateSectionId(section.id, newId);
                            },
                          ),
                        ),
                        IconButton(
                          tooltip: 'حذف القسم',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text('تأكيد الحذف'),
                                content: Text(
                                    'سيتم حذف القسم "${section.id}" ولا يمكن التراجع، هل أنت متأكد؟'),
                                actions: [
                                  TextButton(
                                      onPressed: () =>
                                          Navigator.pop(ctx, false),
                                      child: const Text('إلغاء')),
                                  FilledButton(
                                      onPressed: () => Navigator.pop(ctx, true),
                                      child: const Text('حذف')),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              AdminController.instance
                                  .deleteSection(section.id);
                              setState(() {});
                            }
                          },
                          icon: const Icon(Icons.delete_forever,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      textDirection: getTextDirectionForLang(
                          LanguageController.instance.currentLanguage.value),
                      controller: _keywords,
                      decoration: const InputDecoration(
                          labelText: 'الكلمات المفتاحية (مفصولة بفواصل)'),
                      onChanged: (val) {
                        final kw = val
                            .split(',')
                            .map((e) => e.trim())
                            .where((e) => e.isNotEmpty)
                            .toList();
                        admin.updateSectionKeywords(kw);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _card(
                child: Wrap(
                  spacing: 6,
                  children: content.languages
                      .map((l) => ChoiceChip(
                            label: Text(l),
                            selected: LanguageController
                                    .instance.currentLanguage.value ==
                                l,
                            onSelected: (_) {
                              LanguageController.instance.changeLanguage(l);
                              setState(() {});
                            },
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
              _card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('عنوان القسم (حسب اللغة الحالية):',
                        style: GoogleFonts.cairo(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    TextFormField(
                      key: ValueKey(
                          'title_${LanguageController.instance.currentLanguage.value}'),
                      textDirection: getTextDirectionForLang(
                          LanguageController.instance.currentLanguage.value),
                      initialValue: section.title.map[LanguageController
                              .instance.currentLanguage.value] ??
                          '',
                      onChanged: (val) => admin.setSectionTitle(
                          LanguageController.instance.currentLanguage.value,
                          val),
                      decoration: const InputDecoration(
                          hintText: 'أدخل عنوان القسم للّغة الحالية'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _card(
                child: _ChildrenSectionsEditor(parent: section),
              ),
              const SizedBox(height: 12),
              _BlocksEditor(),
            ],
          ),
        ),
      );
    }); // إغلاق Obx
  }

  Widget _card({required Widget child}) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.cardColor,
          borderRadius: BorderRadius.circular(8),
          border:
              Border.all(color: AppTheme.primaryBlue.withValues(alpha: 0.2)),
        ),
        child: child,
      );
}

class _ChildrenSectionsEditor extends StatefulWidget {
  final SectionModel parent;
  const _ChildrenSectionsEditor({required this.parent});
  @override
  State<_ChildrenSectionsEditor> createState() =>
      _ChildrenSectionsEditorState();
}

class _ChildrenSectionsEditorState extends State<_ChildrenSectionsEditor> {
  @override
  Widget build(BuildContext context) {
    final admin = AdminController.instance;
    final c = admin.content!;
    final available = c.sectionsById.values
        .where((s) =>
            s.id != widget.parent.id && !widget.parent.children.contains(s.id))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('أقسام فرعية',
            style: GoogleFonts.cairo(fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        if (widget.parent.children.isEmpty)
          const Text('لا توجد أقسام فرعية بعد', style: TextStyle(fontSize: 12))
        else
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              admin.moveChildSection(widget.parent.id, oldIndex, newIndex);
              setState(() {});
            },
            children: widget.parent.children.asMap().entries.map((entry) {
              final index = entry.key;
              final id = entry.value;
              return ListTile(
                key: ValueKey('child_$id'),
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_indicator, size: 20),
                ),
                title: Text(
                    c.sectionsById[id]?.title.resolve(c.defaultLanguage) ?? id),
                subtitle: Text(id, style: GoogleFonts.cairo(fontSize: 11)),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    admin.removeChildSection(widget.parent.id, id);
                    setState(() {});
                  },
                ),
              );
            }).toList(),
          ),
        const SizedBox(height: 8),
        if (available.isNotEmpty)
          FilledButton.icon(
            onPressed: () => _showAddChildDialog(context, available, c, admin),
            icon: const Icon(Icons.add),
            label: const Text('إضافة قسم فرعي'),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.primaryBlue,
            ),
          )
        else
          const Text('لا توجد أقسام متاحة للإضافة',
              style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Future<void> _showAddChildDialog(
      BuildContext context,
      List<SectionModel> available,
      SiteContent c,
      AdminController admin) async {
    // تصفية المكررات
    final uniqueMap = <String, SectionModel>{};
    for (final s in available) {
      uniqueMap[s.id] = s;
    }
    final uniqueSections = uniqueMap.values.toList()
      ..sort((a, b) => a.order.compareTo(b.order));

    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppTheme.surfaceColor,
        title: Text('اختر قسمًا لإضافته', style: GoogleFonts.cairo()),
        content: SizedBox(
          width: 400,
          child: ListView(
            shrinkWrap: true,
            children: uniqueSections
                .map((s) => ListTile(
                      title: Text(s.title.resolve(c.defaultLanguage)),
                      subtitle:
                          Text(s.id, style: GoogleFonts.cairo(fontSize: 11)),
                      onTap: () => Navigator.pop(ctx, s.id),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
        ],
      ),
    );

    if (selected != null && mounted) {
      admin.addChildSection(widget.parent.id, selected);
      setState(() {});
    }
  }
}

class _BlocksEditor extends StatefulWidget {
  const _BlocksEditor();
  @override
  State<_BlocksEditor> createState() => _BlocksEditorState();
}

class _BlocksEditorState extends State<_BlocksEditor> {
  static const blockTypes = [
    'title',
    'subtitle',
    'paragraph',
    'note',
    'warning',
    'divider',
    'gap',
    'feature_list',
    'list',
    'code',
    'image',
    'video',
    'subsection',
    'custom',
  ];
  @override
  Widget build(BuildContext context) {
    final admin = AdminController.instance;
    final section = admin.selectedSection!;
    final lang = LanguageController.instance.currentLanguage.value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FilledButton.icon(
              onPressed: () => _showAddBlockMenu(context),
              icon: const Icon(Icons.add),
              label: const Text('إضافة بلوك'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(width: 12),
            FilledButton.icon(
              onPressed: () async {
                await admin.saveToLocalAndApply();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم الحفظ محليًا')));
                }
              },
              icon: const Icon(Icons.save),
              label: const Text('حفظ محلي'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          // height: MediaQuery.of(context).size.height,
          child: ReorderableListView.builder(
            primary: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: section.blocks.length,
            onReorder: (oldIndex, newIndex) {
              admin.moveBlock(oldIndex, newIndex);
              setState(() {});
            },
            buildDefaultDragHandles: false,
            itemBuilder: (context, index) {
              final b = section.blocks[index];
              return Card(
                key: ValueKey('block_$index'),
                color: AppTheme.cardColor,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ReorderableDragStartListener(
                            index: index,
                            child: const Icon(Icons.drag_indicator),
                          ),
                          const SizedBox(width: 8),
                          DropdownButton<String>(
                            value: b.type,
                            items: blockTypes
                                .map((t) =>
                                    DropdownMenuItem(value: t, child: Text(t)))
                                .toList(),
                            onChanged: (v) {
                              if (v == null) return;
                              // إنشاء نسخة قابلة للتعديل من props
                              final newProps =
                                  Map<String, dynamic>.from(b.props);
                              section.blocks[index] = BlockModel(
                                type: v,
                                content: b.content,
                                props: newProps,
                              );
                              setState(() {});
                            },
                          ),
                          const Spacer(),
                          IconButton(
                            tooltip: 'حذف',
                            onPressed: () {
                              admin.removeBlock(index);
                              setState(() {});
                            },
                            icon: const Icon(Icons.delete, color: Colors.red),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _buildBlockEditor(index, b, lang),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _showAddBlockMenu(BuildContext context) async {
    final type = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: blockTypes
          .map((t) => PopupMenuItem<String>(value: t, child: Text(t)))
          .toList(),
    );
    if (type != null) {
      AdminController.instance.addBlock(type);
      setState(() {});
    }
  }

  Widget _buildBlockEditor(int index, BlockModel b, String lang) {
    switch (b.type) {
      case 'divider':
        return const Divider();
      case 'subsection':
        return _SubsectionEditor(blockIndex: index, lang: lang);
      case 'image':
        final imageUrls = (b.props['urls'] as List?)?.cast<String>() ??
            [(b.props['url'] ?? '').toString()];
        if (b.props['url'] != null && b.props['urls'] == null) {
          b.props['urls'] = [b.props['url'].toString()];
          b.props.remove('url');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                labelText: 'عرض الصور (%, px أو اتركه فارغًا للعرض الكامل)',
                hintText: 'مثال: 50%, 300px',
              ),
              controller: TextEditingController(
                  text: (b.props['width'] ?? '').toString()),
              onChanged: (val) =>
                  AdminController.instance.setBlockProp(index, 'width', val),
            ),
            const SizedBox(height: 12),
            ...List.generate(imageUrls.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textDirection: getTextDirectionForLang(lang),
                        decoration: InputDecoration(
                          labelText: 'Image URL ${i + 1}',
                        ),
                        controller: TextEditingController(text: imageUrls[i]),
                        onChanged: (val) {
                          imageUrls[i] = val;
                          AdminController.instance
                              .setBlockProp(index, 'urls', imageUrls);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: imageUrls.length > 1
                          ? () => setState(() {
                                imageUrls.removeAt(i);
                                AdminController.instance
                                    .setBlockProp(index, 'urls', imageUrls);
                              })
                          : null,
                    ),
                  ],
                ),
              );
            }),
            FilledButton.icon(
              onPressed: () => setState(() {
                imageUrls.add('');
                AdminController.instance.setBlockProp(index, 'urls', imageUrls);
              }),
              icon: const Icon(Icons.add),
              label: const Text('إضافة صورة'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        );
      case 'gap':
        return TextField(
          textDirection: getTextDirectionForLang(lang),
          decoration:
              const InputDecoration(labelText: 'ارتفاع المسافة (بالبكسل)'),
          controller: TextEditingController(
              text: (b.props['height'] ?? '16').toString()),
          onChanged: (val) =>
              AdminController.instance.setBlockProp(index, 'height', val),
        );
      case 'video':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                  labelText: 'Video URL (YouTube/Vimeo/MP4)'),
              controller: TextEditingController(
                  text: (b.props['url'] ?? '').toString()),
              onChanged: (val) =>
                  AdminController.instance.setBlockProp(index, 'url', val),
            ),
            const SizedBox(height: 8),
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                labelText: 'عرض الفيديو (%, px أو اتركه فارغًا للعرض الكامل)',
                hintText: 'مثال: 80%, 600px',
              ),
              controller: TextEditingController(
                  text: (b.props['width'] ?? '').toString()),
              onChanged: (val) =>
                  AdminController.instance.setBlockProp(index, 'width', val),
            ),
            const SizedBox(height: 8),
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                  labelText: 'Aspect Ratio (مثال: 1.777 لـ 16:9)'),
              controller: TextEditingController(
                  text: (b.props['aspectRatio'] ?? '1.777').toString()),
              onChanged: (val) => AdminController.instance
                  .setBlockProp(index, 'aspectRatio', val),
            ),
          ],
        );
      case 'code':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration:
                  const InputDecoration(labelText: 'Language (dart/js/…)'),
              controller: TextEditingController(
                  text: (b.props['language'] ?? 'dart').toString()),
              onChanged: (val) =>
                  AdminController.instance.setBlockProp(index, 'language', val),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Code (حسب اللغة الحالية: $lang)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final currentCode = b.content.map[lang] ?? '';
                    if (currentCode.isEmpty) return;
                    final admin = AdminController.instance;
                    for (final l in admin.languages) {
                      if (l != lang) {
                        admin.setBlockContent(index, l, currentCode);
                      }
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تمت مزامنة الكود لجميع اللغات'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.sync, size: 18),
                  label: const Text('مزامنة'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                maxLines: 8,
                decoration: const InputDecoration(
                    labelText: 'Code', hintText: 'اكتب الكود هنا...'),
                controller:
                    TextEditingController(text: b.content.map[lang] ?? ''),
                onChanged: (val) =>
                    AdminController.instance.setBlockContent(index, lang, val),
              ),
            ),
          ],
        );
      case 'list':
      case 'feature_list':
        final items = (b.props['items'] as List?) ?? [];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: ValueKey('list_item_${index}_${i}_$lang'),
                      textDirection: getTextDirectionForLang(lang),
                      decoration:
                          InputDecoration(labelText: 'عنصر ${i + 1} ($lang)'),
                      initialValue: ((items[i] as Map)[lang] ?? '').toString(),
                      onChanged: (val) => AdminController.instance
                          .setItemValue(index, i, lang, val),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      AdminController.instance.removeItem(index, i);
                    }),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                  ),
                ],
              ),
            const SizedBox(height: 6),
            FilledButton.icon(
              onPressed: () => setState(() {
                AdminController.instance.addItem(index);
              }),
              icon: const Icon(Icons.add),
              label: const Text('إضافة عنصر'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        );
      default:
        return TextFormField(
          key: ValueKey('block_${index}_$lang'),
          textDirection: getTextDirectionForLang(lang),
          maxLines: b.type == 'paragraph' ? 5 : 2,
          decoration:
              const InputDecoration(labelText: 'النص (حسب اللغة الحالية)'),
          initialValue: b.content.map[lang] ?? '',
          onChanged: (val) =>
              AdminController.instance.setBlockContent(index, lang, val),
        );
    }
  }
}

class _SubsectionEditor extends StatefulWidget {
  final int blockIndex;
  final String lang;
  const _SubsectionEditor({required this.blockIndex, required this.lang});
  @override
  State<_SubsectionEditor> createState() => _SubsectionEditorState();
}

class _SubsectionEditorState extends State<_SubsectionEditor> {
  static const childTypes = [
    'title',
    'subtitle',
    'paragraph',
    'note',
    'warning',
    'divider',
    'gap',
    'feature_list',
    'list',
    'code',
    'image',
    'video',
    'custom',
  ];

  List<Map<String, dynamic>> get _children {
    final s = AdminController.instance.selectedSection!;
    final props = s.blocks[widget.blockIndex].props;
    final list = (props['children'] as List?)?.cast<Map<String, dynamic>>() ??
        <Map<String, dynamic>>[];
    props['children'] = list;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final s = AdminController.instance.selectedSection!;
    final block = s.blocks[widget.blockIndex];
    final lang = widget.lang;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          key: ValueKey('subsection_${widget.blockIndex}_$lang'),
          textDirection: getTextDirectionForLang(lang),
          decoration: const InputDecoration(
              labelText: 'عنوان الفرع (حسب اللغة الحالية)'),
          initialValue: block.content.map[lang] ?? '',
          onChanged: (val) {
            AdminController.instance
                .setBlockContent(widget.blockIndex, lang, val);
            setState(() {});
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            FilledButton.icon(
              onPressed: _addChild,
              icon: const Icon(Icons.add),
              label: const Text('إضافة عنصر داخل الفرع'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...List.generate(_children.length, (i) => _childCard(i, lang)),
      ],
    );
  }

  Widget _childCard(int i, String lang) {
    final child = _children[i];
    final type = (child['type'] ?? 'paragraph').toString();
    final contentMap = (child['content'] as Map?)?.cast<String, dynamic>() ??
        <String, dynamic>{};
    contentMap.putIfAbsent(lang, () => '');
    child['content'] = contentMap;
    final props = (child['props'] as Map?)?.cast<String, dynamic>() ??
        <String, dynamic>{};
    child['props'] = props;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      color: AppTheme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DropdownButton<String>(
                  value: type,
                  items: childTypes
                      .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                      .toList(),
                  onChanged: (v) {
                    if (v == null) return;
                    child['type'] = v;
                    setState(() {});
                  },
                ),
                const Spacer(),
                IconButton(
                  tooltip: 'أعلى',
                  onPressed: i > 0
                      ? () => setState(() {
                            final it = _children.removeAt(i);
                            _children.insert(i - 1, it);
                          })
                      : null,
                  icon: const Icon(Icons.arrow_upward),
                ),
                IconButton(
                  tooltip: 'أسفل',
                  onPressed: i < _children.length - 1
                      ? () => setState(() {
                            final it = _children.removeAt(i);
                            _children.insert(i + 1, it);
                          })
                      : null,
                  icon: const Icon(Icons.arrow_downward),
                ),
                IconButton(
                  tooltip: 'حذف',
                  onPressed: () => setState(() {
                    _children.removeAt(i);
                  }),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildChildEditor(type, child, lang),
          ],
        ),
      ),
    );
  }

  Widget _buildChildEditor(
      String type, Map<String, dynamic> child, String lang) {
    final contentMap = (child['content'] as Map).cast<String, dynamic>();
    final props = (child['props'] as Map).cast<String, dynamic>();
    switch (type) {
      case 'divider':
        return const Divider();
      case 'gap':
        return TextField(
          textDirection: getTextDirectionForLang(lang),
          decoration:
              const InputDecoration(labelText: 'ارتفاع المسافة (بالبكسل)'),
          controller:
              TextEditingController(text: (props['height'] ?? '16').toString()),
          onChanged: (v) => setState(() {
            props['height'] = v;
          }),
        );
      case 'image':
        final imageUrls = (props['urls'] as List?)?.cast<String>() ??
            [(props['url'] ?? '').toString()];
        if (props['url'] != null && props['urls'] == null) {
          props['urls'] = [props['url'].toString()];
          props.remove('url');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                labelText: 'عرض الصور (%, px أو اتركه فارغًا للعرض الكامل)',
                hintText: 'مثال: 50%, 300px',
              ),
              controller: TextEditingController(
                  text: (props['width'] ?? '').toString()),
              onChanged: (v) => setState(() {
                props['width'] = v;
              }),
            ),
            const SizedBox(height: 12),
            ...List.generate(imageUrls.length, (i) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        textDirection: getTextDirectionForLang(lang),
                        decoration: InputDecoration(
                          labelText: 'Image URL ${i + 1}',
                        ),
                        controller: TextEditingController(text: imageUrls[i]),
                        onChanged: (val) => setState(() {
                          imageUrls[i] = val;
                          props['urls'] = imageUrls;
                        }),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: imageUrls.length > 1
                          ? () => setState(() {
                                imageUrls.removeAt(i);
                                props['urls'] = imageUrls;
                              })
                          : null,
                    ),
                  ],
                ),
              );
            }),
            FilledButton.icon(
              onPressed: () => setState(() {
                imageUrls.add('');
                props['urls'] = imageUrls;
              }),
              icon: const Icon(Icons.add),
              label: const Text('إضافة صورة'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        );
      case 'video':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                  labelText: 'Video URL (YouTube/Vimeo/MP4)'),
              controller:
                  TextEditingController(text: (props['url'] ?? '').toString()),
              onChanged: (v) => setState(() {
                props['url'] = v;
              }),
            ),
            const SizedBox(height: 8),
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                labelText: 'عرض الفيديو (%, px أو اتركه فارغًا للعرض الكامل)',
                hintText: 'مثال: 80%, 600px',
              ),
              controller: TextEditingController(
                  text: (props['width'] ?? '').toString()),
              onChanged: (v) => setState(() {
                props['width'] = v;
              }),
            ),
            const SizedBox(height: 8),
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration: const InputDecoration(
                  labelText: 'Aspect Ratio (مثال: 1.777 لـ 16:9)'),
              controller: TextEditingController(
                  text: (props['aspectRatio'] ?? '1.777').toString()),
              onChanged: (v) => setState(() {
                props['aspectRatio'] = v;
              }),
            ),
          ],
        );
      case 'code':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              textDirection: getTextDirectionForLang(lang),
              decoration:
                  const InputDecoration(labelText: 'Language (dart/js/…)'),
              controller: TextEditingController(
                  text: (props['language'] ?? 'dart').toString()),
              onChanged: (v) => setState(() {
                props['language'] = v;
              }),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Code (حسب اللغة الحالية: $lang)',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final currentCode = (contentMap[lang] ?? '').toString();
                    if (currentCode.isEmpty) return;
                    final admin = AdminController.instance;
                    for (final l in admin.languages) {
                      if (l != lang) {
                        contentMap[l] = currentCode;
                      }
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('تمت مزامنة الكود لجميع اللغات'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    setState(() {});
                  },
                  icon: const Icon(Icons.sync, size: 18),
                  label: const Text('مزامنة'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.primaryBlue,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: TextField(
                maxLines: 8,
                decoration: const InputDecoration(
                    labelText: 'Code', hintText: 'اكتب الكود هنا...'),
                controller: TextEditingController(
                    text: (contentMap[lang] ?? '').toString()),
                onChanged: (v) => setState(() {
                  contentMap[lang] = v;
                }),
              ),
            ),
          ],
        );
      case 'list':
      case 'feature_list':
        final items = (props['items'] as List?) ?? [];
        props['items'] = items;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < items.length; i++)
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      key: ValueKey(
                          'subchild_list_${widget.blockIndex}_${child.hashCode}_${i}_$lang'),
                      textDirection: getTextDirectionForLang(lang),
                      decoration:
                          InputDecoration(labelText: 'عنصر ${i + 1} ($lang)'),
                      initialValue:
                          (((items[i] as Map)[lang]) ?? '').toString(),
                      onChanged: (val) => setState(() {
                        final m = (items[i] as Map).cast<String, dynamic>();
                        m[lang] = val;
                        items[i] = m;
                      }),
                    ),
                  ),
                  IconButton(
                    onPressed: () => setState(() {
                      items.removeAt(i);
                    }),
                    icon: const Icon(Icons.remove_circle, color: Colors.red),
                  ),
                ],
              ),
            const SizedBox(height: 6),
            FilledButton.icon(
              onPressed: () => setState(() {
                items.add({lang: ''});
              }),
              icon: const Icon(Icons.add),
              label: const Text('إضافة عنصر'),
              style: FilledButton.styleFrom(
                backgroundColor: AppTheme.primaryBlue,
              ),
            ),
          ],
        );
      default:
        return TextFormField(
          key: ValueKey('child_${widget.blockIndex}_${child.hashCode}_$lang'),
          textDirection: getTextDirectionForLang(lang),
          maxLines: type == 'paragraph' ? 5 : 2,
          decoration:
              const InputDecoration(labelText: 'النص (حسب اللغة الحالية)'),
          initialValue: (contentMap[lang] ?? '').toString(),
          onChanged: (v) => setState(() {
            contentMap[lang] = v;
          }),
        );
    }
  }

  void _addChild() async {
    final type = await showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(100, 100, 0, 0),
      items: childTypes
          .map((t) => PopupMenuItem<String>(value: t, child: Text(t)))
          .toList(),
    );
    if (type != null) {
      setState(() {
        _children.add({
          'type': type,
          'content': {widget.lang: ''},
          'props': <String, dynamic>{},
        });
      });
    }
  }
}
