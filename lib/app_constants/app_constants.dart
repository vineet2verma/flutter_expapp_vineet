
import 'image_constants.dart';
import '../models/cat_model.dart';

class AppConstants {

  /// default categories
  static final List<CategoryModel> mCategory = [

    CategoryModel(catID: 1, catTitle: "Travel", catImgPath: ImageConstants.IMG_PATH_TRAVEL),
    CategoryModel(catID: 2, catTitle: "Coffee", catImgPath: ImageConstants.IMG_PATH_COFFEE),
    CategoryModel(catID: 3, catTitle: "Recharge", catImgPath: ImageConstants.IMG_PATH_TRANSFER),
    CategoryModel(catID: 4, catTitle: "Groceries", catImgPath: ImageConstants.IMG_PATH_VEGETABLE),
    CategoryModel(catID: 5, catTitle: "Movie", catImgPath: ImageConstants.IMG_PATH_POPCORN),
    CategoryModel(catID: 6, catTitle: "Restaurant", catImgPath: ImageConstants.IMG_PATH_RESTAURANT),
    CategoryModel(catID: 7, catTitle: "Rent", catImgPath: ImageConstants.IMG_PATH_TRANSFER),
    CategoryModel(catID: 8, catTitle: "Petrol", catImgPath: ImageConstants.IMG_PATH_SMARTPHONE),
    CategoryModel(catID: 9, catTitle: "Snacks", catImgPath: ImageConstants.IMG_PATH_FASHFOOD),
    CategoryModel(catID: 10, catTitle: "Shopping", catImgPath: ImageConstants.IMG_PATH_SHOPPING),
    CategoryModel(catID: 11, catTitle: "Salon", catImgPath: ImageConstants.IMG_PATH_MAKEUP),
    CategoryModel(catID: 12, catTitle: "Medicine", catImgPath: ImageConstants.IMG_PATH_TOOLS),

  ];
}