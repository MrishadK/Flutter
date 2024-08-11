import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Phone Market',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
        '/cart': (context) => const CartPage(),
      },
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.network(
              'https://i.imgur.com/XE8jaIr.jpeg', // Replace with your background image URL
              fit: BoxFit.cover,
            ),
          ),
          // Centered login box
          Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9), // Slightly transparent white
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Online Mobile Market',
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      // Handle sign-up logic here
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone eShop'),
        toolbarHeight: 80.0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: const TextStyle(
          color: Colors.white, // Change the color here
          fontSize: 20,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Colors.white,
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 300, // Increased height for offers
            child: PageView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) {
                final offer = offers[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5.0,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12.0)),
                              child: Image.network(
                                offer.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            offer.title,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            offer.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Colors.black,
                                ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.76,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: mobiles.length,
              itemBuilder: (context, index) {
                return MobileTile(mobile: mobiles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MobileTile extends StatelessWidget {
  final Mobile mobile;
  const MobileTile({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) {
            return FadeTransition(
              opacity: animation,
              child: ProductDetailPage(mobile: mobile),
            );
          },
        ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 4.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: Image.network(
                  mobile.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                mobile.name,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                '\$${mobile.price}',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.grey[800],
                    ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                onPressed: () {
                  cart.add(mobile);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${mobile.name} added to cart'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final Mobile mobile;
  const ProductDetailPage({super.key, required this.mobile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(mobile.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Image.network(
                mobile.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              mobile.name,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Price: \$${mobile.price}',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 16.0),
            Text(
              mobile.description,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  cart.add(mobile);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${mobile.name} added to cart'),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
                child: const Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final mobile = cart[index];
          return ListTile(
            leading: Image.network(mobile.imageUrl),
            title: Text(mobile.name),
            subtitle: Text('\$${mobile.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () {
                cart.removeAt(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${mobile.name} removed from cart'),
                  ),
                );
                (context as Element).markNeedsBuild();
              },
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: cart.isEmpty
              ? null
              : () {
                  // Handle checkout logic
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

class Mobile {
  final String name;
  final String imageUrl;
  final double price;
  final String description;

  Mobile({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.description,
  });
}

class Offer {
  final String title;
  final String description;
  final String imageUrl;

  Offer({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

final List<Mobile> mobiles = [
  Mobile(
    name: 'iPhone 13',
    imageUrl: 'https://i.imgur.com/ZIbPdjS.jpeg',
    price: 999.99,
    description: 'The iPhone 13 features a sleek design and the latest technology from Apple. With an A15 Bionic chip and improved cameras, it offers a top-notch performance.',
  ),
  Mobile(
    name: 'S22 Ultra',
    imageUrl: 'https://i.imgur.com/EWkRDE6.jpeg',
    price: 799.99,
    description: 'Samsung Galaxy S22 Ultra combines a high-quality camera system with a large display and powerful performance. Ideal for both work and play.',
  ),
  Mobile(
    name: 'Iqoo 12',
    imageUrl: 'https://i.imgur.com/6HFSg8O.jpeg',
    price: 699.99,
    description: 'The Iqoo 12 Legend is a high-performance smartphone with an impressive display and fast charging capabilities. Perfect for gaming and multitasking.',
  ),
  Mobile(
    name: 'TypeC Cable',
    imageUrl: 'https://i.imgur.com/GxVekHf.jpeg',
    price: 9.99,
    description: 'Type C charging cable, Fast charging Support (65watt), 1 meter long',
  ),
];

final List<Mobile> cart = [];

final List<Offer> offers = [
  Offer(
    title: '10% OFF',
    description: 'On selected items',
    imageUrl: 'https://i.imgur.com/9b7ZiPW.png',
  ),
  Offer(
    title: 'Get Free Extra Warranty',
    description: 'On selected products',
    imageUrl: 'https://i.imgur.com/bdgCGXC.png',
  ),
  Offer(
    title: 'Free Shipping',
    description: 'On every item',
    imageUrl: 'https://i.imgur.com/5JSSIQr.png',
  ),
];
