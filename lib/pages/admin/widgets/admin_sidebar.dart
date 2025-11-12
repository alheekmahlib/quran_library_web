import 'package:flutter/material.dart';
// ignore_for_file: unused_import
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants/app_theme.dart';
import '../../../controllers/admin_controller.dart';
import '../../../controllers/content_controller.dart';
import '../../../core/content/content_models.dart';

class AdminSidebar extends StatefulWidget {
  const AdminSidebar({super.key});
  @override
  State<AdminSidebar> createState() => _AdminSidebarState();
}

class _AdminSidebarState extends State<AdminSidebar> {
  final TextEditingController _search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final admin = AdminController.instance;
    final c = admin.content!;
    final lang = c.defaultLanguage;
    final query = _search.text.trim().toLowerCase();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _search,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'بحث عن قسم...',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                onPressed: () async {
                  final added = await _openNewStandaloneSectionDialog(context);
                  if (added == true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تمت إضافة القسم')));
                    setState(() {});
                  }
                },
                icon: const Icon(Icons.add),
                label: const Text('قسم'),
                style: FilledButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: ReorderableListView(
            buildDefaultDragHandles: false,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final group = c.groups.removeAt(oldIndex);
              c.groups.insert(newIndex, group);
              admin.working.refresh();
              setState(() {});
            },
            children: c.groups.asMap().entries.map((entry) {
              final index = entry.key;
              final g = entry.value;
              final title = g.title.resolve(lang);
              final ids = g.sectionIds.where((id) {
                if (query.isEmpty) return true;
                final s = c.sectionsById[id];
                final t = s?.title.resolve(lang).toLowerCase() ?? '';
                return t.contains(query) || id.toLowerCase().contains(query);
              }).toList();

              return ExpansionTile(
                key: ValueKey('group_${g.id}'),
                leading: ReorderableDragStartListener(
                  index: index,
                  child: const Icon(Icons.drag_indicator, size: 20),
                ),
                title: Text(title, style: GoogleFonts.cairo(fontSize: 16)),
                children: [
                  ListTile(
                    leading: const Icon(Icons.add_circle_outline),
                    title: const Text('إضافة قسم رئيسي في هذه المجموعة'),
                    onTap: () async {
                      final added = await _openNewSectionDialog(context,
                          initialGroupId: g.id);
                      if (added == true && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('تمت إضافة القسم الرئيسي')));
                        setState(() {});
                      }
                    },
                  ),
                  ReorderableListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    onReorder: (oldIndex, newIndex) {
                      if (oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      final sectionId = ids[oldIndex];
                      ids.removeAt(oldIndex);
                      ids.insert(newIndex, sectionId);
                      // تحديث ترتيب الأقسام في المجموعة
                      g.sectionIds.clear();
                      g.sectionIds.addAll(ids);
                      admin.working.refresh();
                      setState(() {});
                    },
                    children: ids.asMap().entries.map((entry) {
                      final index = entry.key;
                      final id = entry.value;
                      final s = c.sectionsById[id]!;
                      final selected = admin.selectedSectionId.value == id;
                      final incomplete = _isSectionIncomplete(s, c.languages);
                      return ListTile(
                        key: ValueKey('section_$id'),
                        selected: selected,
                        leading: ReorderableDragStartListener(
                          index: index,
                          child: const Icon(Icons.drag_indicator, size: 20),
                        ),
                        title: Text(
                          s.title.resolve(lang),
                          style: GoogleFonts.cairo(
                            fontWeight:
                                selected ? FontWeight.w700 : FontWeight.w400,
                          ),
                        ),
                        subtitle:
                            Text(id, style: GoogleFonts.cairo(fontSize: 12)),
                        trailing: incomplete
                            ? const Icon(Icons.warning_amber,
                                color: Colors.orange, size: 18)
                            : null,
                        onTap: () => admin.selectSection(id),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  bool _isSectionIncomplete(SectionModel s, List<String> langs) {
    for (final l in langs) {
      final v = s.title.map[l]?.trim() ?? '';
      if (v.isEmpty) return true;
    }
    return false;
  }

  Future<bool?> _openNewSectionDialog(BuildContext context,
      {String? initialGroupId}) async {
    final admin = AdminController.instance;
    final c = admin.content;
    if (c == null) return false;
    final idCtrl = TextEditingController();
    final keywordsCtrl = TextEditingController();
    final titles = {for (final l in c.languages) l: TextEditingController()};
    final para = {for (final l in c.languages) l: TextEditingController()};
    String groupId = initialGroupId ?? c.groups.first.id;
    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: AppTheme.surfaceColor,
              title: Text('قسم جديد', style: GoogleFonts.cairo()),
              content: SizedBox(
                width: 600,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('المجموعة:',
                          style:
                              GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      DropdownButton<String>(
                        value: groupId,
                        isExpanded: true,
                        onChanged: (v) =>
                            setDialogState(() => groupId = v ?? groupId),
                        items: [
                          for (final g in c.groups)
                            DropdownMenuItem(
                              value: g.id,
                              child: Text(g.title.resolve(c.defaultLanguage)),
                            )
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: idCtrl,
                        decoration: const InputDecoration(
                            labelText: 'Section ID (بالإنجليزية، فريد)'),
                      ),
                      TextField(
                        controller: keywordsCtrl,
                        decoration: const InputDecoration(
                            labelText: 'الكلمات المفتاحية (مفصولة بفواصل)'),
                      ),
                      const SizedBox(height: 12),
                      Text('العناوين لكل لغة:',
                          style:
                              GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      ...c.languages.map((l) => TextField(
                            controller: titles[l],
                            decoration:
                                InputDecoration(labelText: 'عنوان ($l)'),
                          )),
                      const SizedBox(height: 12),
                      Text('محتوى فقرة أولية لكل لغة:',
                          style:
                              GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      ...c.languages.map((l) => TextField(
                            controller: para[l],
                            decoration: InputDecoration(labelText: 'فقرة ($l)'),
                            maxLines: 3,
                          )),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(ctx, false),
                    child: const Text('إلغاء')),
                FilledButton(
                  onPressed: () async {
                    final id = idCtrl.text.trim();
                    if (id.isEmpty || c.sectionsById.containsKey(id)) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('المعرّف فارغ أو مستخدم مسبقًا')));
                      return;
                    }
                    final kw = keywordsCtrl.text
                        .split(',')
                        .map((e) => e.trim())
                        .where((e) => e.isNotEmpty)
                        .toList();
                    final titleLt = LocalizedText({
                      for (final l in c.languages) l: titles[l]!.text.trim()
                    });
                    final paraLt = LocalizedText(
                        {for (final l in c.languages) l: para[l]!.text.trim()});
                    final newSection = SectionModel(
                      id: id,
                      title: titleLt,
                      order: 9999,
                      keywords: kw,
                      blocks: [
                        BlockModel(
                            type: 'title', content: titleLt, props: const {}),
                        BlockModel(
                            type: 'paragraph',
                            content: paraLt,
                            props: const {}),
                      ],
                    );
                    admin.addSection(groupId, newSection);
                    if (ctx.mounted) Navigator.pop(ctx, true);
                  },
                  child: const Text('حفظ'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Dialog لإضافة قسم مستقل (خارج المجموعات)
  Future<bool?> _openNewStandaloneSectionDialog(BuildContext context) async {
    final admin = AdminController.instance;
    final c = admin.content;
    if (c == null) return false;
    final idCtrl = TextEditingController();
    final keywordsCtrl = TextEditingController();
    final titles = {for (final l in c.languages) l: TextEditingController()};
    final para = {for (final l in c.languages) l: TextEditingController()};

    return showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text('قسم مستقل جديد', style: GoogleFonts.cairo()),
          content: SizedBox(
            width: 600,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'هذا القسم سيكون مستقلاً ولن يظهر داخل أي مجموعة',
                    style: GoogleFonts.cairo(
                      fontSize: 14,
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: idCtrl,
                    decoration: const InputDecoration(
                        labelText: 'Section ID (بالإنجليزية، فريد)'),
                  ),
                  TextField(
                    controller: keywordsCtrl,
                    decoration: const InputDecoration(
                        labelText: 'الكلمات المفتاحية (مفصولة بفواصل)'),
                  ),
                  const SizedBox(height: 12),
                  Text('العناوين لكل لغة:',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  ...c.languages.map((l) => TextField(
                        controller: titles[l],
                        decoration: InputDecoration(labelText: 'عنوان ($l)'),
                      )),
                  const SizedBox(height: 12),
                  Text('محتوى فقرة أولية لكل لغة:',
                      style: GoogleFonts.cairo(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  ...c.languages.map((l) => TextField(
                        controller: para[l],
                        decoration: InputDecoration(labelText: 'فقرة ($l)'),
                        maxLines: 3,
                      )),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('إلغاء')),
            FilledButton(
              onPressed: () async {
                final id = idCtrl.text.trim();
                if (id.isEmpty || c.sectionsById.containsKey(id)) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('المعرّف فارغ أو مستخدم مسبقًا')));
                  return;
                }
                final kw = keywordsCtrl.text
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
                final titleLt = LocalizedText(
                    {for (final l in c.languages) l: titles[l]!.text.trim()});
                final paraLt = LocalizedText(
                    {for (final l in c.languages) l: para[l]!.text.trim()});
                final newSection = SectionModel(
                  id: id,
                  title: titleLt,
                  order: 9999,
                  keywords: kw,
                  blocks: [
                    BlockModel(
                        type: 'title', content: titleLt, props: const {}),
                    BlockModel(
                        type: 'paragraph', content: paraLt, props: const {}),
                  ],
                );
                admin.addStandaloneSection(newSection);
                if (ctx.mounted) Navigator.pop(ctx, true);
              },
              child: const Text('حفظ'),
            ),
          ],
        );
      },
    );
  }
}
