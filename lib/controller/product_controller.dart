import 'package:get/get.dart'; 
import 'package:test/const.dart'; 
import 'package:test/model/product_model.dart'; 
import 'package:test/repo/db_repo.dart';

class ProductController extends GetxController {
  // A list of predefined products available locally.
  final List<Product> productsInLocal = [
    Product(
      id: 1,
      name: 'Grand Theft Auto V',
      imageUrl: 'assets/images/vice1.png',
      price: 2499.0,
      description:
          'An open-world action-adventure game where players can explore a sprawling city while completing missions.',
    ),
    Product(
      id: 2,
      name: 'Cyberpunk 2077',
      imageUrl: 'assets/images/vice2.png',
      price: 3499.0,
      description:
          'A futuristic RPG with a deep narrative set in a dystopian cyberpunk world, featuring action-packed gameplay and rich storytelling.',
    ),
    Product(
      id: 3,
      name: 'The Witcher 3: Wild Hunt',
      imageUrl: 'assets/images/vice3.png',
      price: 1999.0,
      description:
          'A critically acclaimed action RPG with a captivating story, set in a fantasy world filled with monsters and political intrigue.',
    ),
    Product(
      id: 4,
      name: 'Red Dead Redemption 2',
      imageUrl: 'assets/images/vice4.png',
      price: 2999.0,
      description:
          'A Western-themed action-adventure game that follows the story of Arthur Morgan, a member of a notorious outlaw gang.',
    ),
    Product(
      id: 5,
      name: 'Assassin’s Creed Valhalla',
      imageUrl: 'assets/images/vice5.png',
      price: 3999.0,
      description:
          'An open-world RPG set in the Viking age, where you play as Eivor, a Viking raider, exploring England and Norway.',
    ),
    Product(
      id: 6,
      name: 'Call of Duty: Modern Warfare II',
      imageUrl: 'assets/images/vice6.png',
      price: 4999.0,
      description:
          'A first-person shooter game that brings back classic combat with modern warfare technology and an intense single-player campaign.',
    ),
    Product(
      id: 7,
      name: 'Horizon Forbidden West',
      imageUrl: 'assets/images/vice7.png',
      price: 4499.0,
      description:
          'An action RPG set in a post-apocalyptic world where humans must fight against robotic creatures to survive.',
    ),
    Product(
      id: 8,
      name: 'God of War: Ragnarok',
      imageUrl: 'assets/images/vice8.png',
      price: 5499.0,
      description:
          'A mythological action-adventure game that continues Kratos’ journey, exploring Norse mythology and battling gods and monsters.',
    ),
    Product(
      id: 9,
      name: 'Elden Ring',
      imageUrl: 'assets/images/vice9.png',
      price: 3999.0,
      description:
          'An open-world action RPG by FromSoftware, known for its challenging combat and deep, lore-rich world.',
    ),
    Product(
      id: 10,
      name: 'Minecraft',
      imageUrl: 'assets/images/vice10.png',
      price: 1299.0,
      description:
          'A sandbox game where players can explore, build, and survive in a blocky world, offering limitless creative potential.',
    ),
    Product(
      id: 11,
      name: 'The Legend of Zelda: Breath of the Wild',
      imageUrl: 'assets/images/vice11.png',
      price: 3999.0,
      description:
          'An open-world adventure game that lets players explore the kingdom of Hyrule, solving puzzles and defeating enemies.',
    ),
    Product(
      id: 12,
      name: 'Fortnite',
      imageUrl: 'assets/images/vice12.png',
      price: 999.0,
      description:
          'A battle royale game where 100 players fight to be the last one standing, with building mechanics and seasonal updates.',
    ),
    Product(
      id: 13,
      name: 'Apex Legends',
      imageUrl: 'assets/images/vice13.png',
      price: 0.0, 
      description:
          'A free-to-play battle royale game that features unique characters with different abilities, set in a futuristic world.',
    ),
  ];

  // A list of products fetched from the database.
  final List<Product> productFromDb = [];

  // Getter to retrieve the products currently in the cart.
  List<Product> get cart =>
      productFromDb.where((product) => product.isInCart).toList();

  // Fetches products from the database and adds them to the local list.
  Future<void> fetchProductsFromDb() async {
    final dbHelper = DatabaseRepo();
    productFromDb.addAll(await dbHelper.fetchProducts());
    update(); 
  }

  // Adds a product to the cart and updates its `isInCart` flag.
  Future<void> addToCart(Product product) async {
    if (product.isInCart) {
      Get.snackbar('Sorry', 'Game is already in the Cart',
          backgroundColor: kred);
    } else {
      final dbHelper = DatabaseRepo();
      // Update the `isInCart` flag in the product and the database.
      product.isInCart = true;
      await dbHelper.updateIsInCart(product.id, true);
      update(); 
    }
  }

  // Removes a product from the cart and updates its `isInCart` flag.
  Future<void> removeFromCart(Product product) async {
    final dbHelper = DatabaseRepo();
    product.isInCart = false;
    await dbHelper.updateIsInCart(product.id, false);
    update(); 
  }

  // Calculates the total cost of all products currently in the cart.
  double get totalCost => productFromDb
      .where((product) => product.isInCart)
      .fold(0, (sum, item) => sum + item.price);
}
