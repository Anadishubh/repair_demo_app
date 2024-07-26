class Dashboard {
  Data data;
  String message;

  Dashboard({
    required this.data,
    required this.message,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    return Dashboard(
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  List<CategoryElement> category;
  List<Banners> banner;

  Data({
    required this.category,
    required this.banner,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var bannersMap = json['banner'] as Map<String, dynamic>;
    List<Banners> bannerItems = bannersMap.entries
        .map((entry) => Banners(imageUrl: entry.value))
        .toList();
    var categoryList = json['category'] as List;
    List<CategoryElement> categories =
        categoryList.map((e) => CategoryElement.fromJson(e)).toList();

    return Data(
      category: categories,
      banner: bannerItems,
    );
  }
}

class CategoryElement {
  int id;
  String name;

  CategoryElement({
    required this.id,
    required this.name,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) {
    return CategoryElement(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Banners {
  final String imageUrl;
  Banners({required this.imageUrl});
}
