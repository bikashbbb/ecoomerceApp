class Product {
  String name;
  String id;
  String price;
  String cutPrice;
  String imageUrl;
  String wholeSalePrice;
  String minOrderQuantity;
  String brand;
  String typeOfPackaging;
  String type;
  String description;
  String category;
  bool isWholeSale;

  Product(
    this.cutPrice,
    this.id,
    this.imageUrl,
    this.name,
    this.price,
    this.brand,
    this.isWholeSale,
    this.minOrderQuantity,
    this.type,
    this.typeOfPackaging,
    this.wholeSalePrice,
    this.category,
    this.description,
  );

  factory Product.toObj(Map snap, String id) {
    return Product(
        snap["cutPrice"],
        id,
        snap["imageUrl"],
        snap["name"],
        snap["price"],
        snap["brand"],
        false,
        snap["minOrderQuantity"],
        snap["type"],
        snap["typeOfPackaging"],
        snap["wholeSalePrice"],
        snap["category"],
        snap[
          "description"
        ]
        );
  }
}
