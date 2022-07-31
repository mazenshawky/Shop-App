class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel
{
  List<BannerModel> banners = [];
  List<ProductModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element)
    {
      banners.add(element);
    });

    json['products'].forEach((element)
    {
      products.add(element);
    });
  }
}

class BannerModel
{
  late int id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
  }
}

class ProductModel
{
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  bool? inFavorites;
  bool? inCart;

  ProductModel(
  {
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    this.inFavorites,
    this.inCart,
  });

  ProductModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}