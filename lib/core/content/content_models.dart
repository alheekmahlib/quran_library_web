import 'dart:convert';

class LocalizedText {
  final Map<String, String> map;
  const LocalizedText(this.map);

  factory LocalizedText.fromJson(Map<String, dynamic>? json) {
    return LocalizedText(json == null
        ? const {}
        : json.map((k, v) => MapEntry(k, v?.toString() ?? '')));
  }

  String resolve(String lang, {String? fallbackLang}) {
    if (map.containsKey(lang) && (map[lang]?.isNotEmpty ?? false)) {
      return map[lang]!;
    }
    if (fallbackLang != null && map.containsKey(fallbackLang)) {
      return map[fallbackLang] ?? '';
    }
    // If nothing found, return any non-empty value or empty string
    return map.values.firstWhere((v) => v.isNotEmpty, orElse: () => '');
  }

  Map<String, dynamic> toJson() => Map<String, String>.from(map);
}

class BlockModel {
  final String
      type; // title, paragraph, code, image, list, note, warning, feature_list, divider, custom
  final LocalizedText content;
  final Map<String, dynamic> props;

  BlockModel({required this.type, required this.content, required this.props});

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    return BlockModel(
      type: (json['type'] ?? '').toString(),
      content: LocalizedText.fromJson(json['content'] as Map<String, dynamic>?),
      props: (json['props'] as Map<String, dynamic>?) ?? const {},
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        if (content.map.isNotEmpty) 'content': content.toJson(),
        if (props.isNotEmpty) 'props': props,
      };
}

class SectionModel {
  final String id;
  final LocalizedText title;
  final int order;
  final List<String> keywords;
  final List<BlockModel> blocks;
  final List<String> children; // IDs لأقسام فرعية حقيقية داخل هذا القسم

  SectionModel({
    required this.id,
    required this.title,
    required this.order,
    required this.keywords,
    required this.blocks,
    List<String>? children,
  }) : children = children ?? const [];

  factory SectionModel.fromJson(Map<String, dynamic> json) {
    return SectionModel(
      id: (json['id'] ?? '').toString(),
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>?),
      order: (json['order'] is int)
          ? json['order'] as int
          : int.tryParse(json['order']?.toString() ?? '') ?? 0,
      keywords: ((json['keywords'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      blocks: ((json['blocks'] as List?) ?? const [])
          .map((e) => BlockModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      children: ((json['children'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title.toJson(),
        'order': order,
        if (keywords.isNotEmpty) 'keywords': keywords,
        'blocks': blocks.map((b) => b.toJson()).toList(),
        if (children.isNotEmpty) 'children': children,
      };
}

class GroupModel {
  final String id;
  final LocalizedText title;
  final int order;
  final List<String> sectionIds;

  GroupModel({
    required this.id,
    required this.title,
    required this.order,
    required this.sectionIds,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: (json['id'] ?? '').toString(),
      title: LocalizedText.fromJson(json['title'] as Map<String, dynamic>?),
      order: (json['order'] is int)
          ? json['order'] as int
          : int.tryParse(json['order']?.toString() ?? '') ?? 0,
      sectionIds: ((json['sections'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title.toJson(),
        'order': order,
        'sections': sectionIds,
      };
}

class SiteContent {
  final int schemaVersion;
  final String lastUpdated;
  final String defaultLanguage;
  final List<String> languages;
  final List<GroupModel> groups;
  final Map<String, SectionModel> sectionsById;

  SiteContent({
    required this.schemaVersion,
    required this.lastUpdated,
    required this.defaultLanguage,
    required this.languages,
    required this.groups,
    required this.sectionsById,
  });

  factory SiteContent.fromJson(Map<String, dynamic> json) {
    final sectionsList = ((json['sections'] as List?) ?? const [])
        .map((e) => SectionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return SiteContent(
      schemaVersion: (json['schemaVersion'] is int)
          ? json['schemaVersion'] as int
          : int.tryParse(json['schemaVersion']?.toString() ?? '') ?? 1,
      lastUpdated: (json['lastUpdated'] ?? '').toString(),
      defaultLanguage: (json['defaultLanguage'] ?? 'ar').toString(),
      languages: ((json['languages'] as List?) ?? const [])
          .map((e) => e.toString())
          .toList(),
      groups: ((json['groups'] as List?) ?? const [])
          .map((e) => GroupModel.fromJson(e as Map<String, dynamic>))
          .toList()
        ..sort((a, b) => a.order.compareTo(b.order)),
      sectionsById: {
        for (final s in sectionsList) s.id: s,
      },
    );
  }

  static SiteContent? tryParse(String jsonString) {
    try {
      final data = json.decode(jsonString) as Map<String, dynamic>;
      return SiteContent.fromJson(data);
    } catch (_) {
      return null;
    }
  }

  Map<String, dynamic> toJson() => {
        'schemaVersion': schemaVersion,
        'lastUpdated': lastUpdated,
        'defaultLanguage': defaultLanguage,
        'languages': languages,
        'groups': groups.map((g) => g.toJson()).toList(),
        'sections': (sectionsById.values.toList()
              ..sort((a, b) => a.order.compareTo(b.order)))
            .map((s) => s.toJson())
            .toList(),
      };
}
