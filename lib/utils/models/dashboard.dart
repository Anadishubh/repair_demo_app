class DashboardResponse {
  Data data;
  String message;

  DashboardResponse({
    required this.data,
    required this.message,
  });

  factory DashboardResponse.fromJson(Map<String, dynamic> json) {
    return DashboardResponse(
      data: Data.fromJson(json['data']),
      message: json['message'],
    );
  }
}

class Data {
  List<CategoryElement> category;
  Banner banner;

  Data({
    required this.category,
    required this.banner,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var categoryList = json['category'] as List;
    List<CategoryElement> categories =
    categoryList.map((e) => CategoryElement.fromJson(e)).toList();

    return Data(
      category: categories,
      banner: Banner.fromJson(json['banner']),
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

class Banner {
  String topBanner1;
  String topBanner2;
  String topBanner3;
  String topBanner4;
  String topBanner5;
  String bottom1;

  Banner({
    required this.topBanner1,
    required this.topBanner2,
    required this.topBanner3,
    required this.topBanner4,
    required this.topBanner5,
    required this.bottom1,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      topBanner1: json['top_banner_1'],
      topBanner2: json['top_banner_2'],
      topBanner3: json['top_banner_3'],
      topBanner4: json['top_banner_4'],
      topBanner5: json['top_banner_5'],
      bottom1: json['bottom_1'],
    );
  }
}