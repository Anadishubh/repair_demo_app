class SubCategory {
  final int id;
  final int categoryId;
  final String name;
  final List<String> images;
  final List<String> beamImages;
  final String faq;
  final bool columnAndBeam;

  SubCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.images,
    required this.beamImages,
    required this.faq,
    required this.columnAndBeam,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      images: [
        json['image_1'],
        json['image_2'],
        json['image_3'],
        json['image_4']
      ].whereType<String>().toList(),
      beamImages: [
        json['image_beam_1'],
        json['image_beam_2'],
        json['image_beam_3'],
        json['image_beam_4']
      ].whereType<String>().toList(),
      faq: json['faq'],
      columnAndBeam: json['column_and_beam'] == 'Yes',
    );
  }
}