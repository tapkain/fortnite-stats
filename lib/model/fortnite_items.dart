enum FortniteItemsQuery { current, upcoming }

class FortniteItem {
  final String name;
  final String cost;
  final String mainImage;
  final String featuredImage;
  final String type;
  final String rarity;

  FortniteItem(
      {this.name,
      this.cost,
      this.mainImage,
      this.featuredImage,
      this.type,
      this.rarity});

  factory FortniteItem.fromJson(Map<String, dynamic> json) {
    final images = json['item']['images'];
    var featured = images['featured'] ?? images;
    featured = featured['transparent'] ?? images['transparent'];
    return FortniteItem(
      name: json['name'],
      cost: json['cost'],
      mainImage: images['background'],
      featuredImage: featured,
      type: json['item']['type'],
      rarity: json['item']['rarity'],
    );
  }
}

class FortniteItems {
  List<FortniteItem> items;

  FortniteItems({this.items});

  factory FortniteItems.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List;
    return FortniteItems(
        items: items.map((i) => FortniteItem.fromJson(i)).toList());
  }
}
