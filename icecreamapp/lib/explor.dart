



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pick.dart';
import 'cart.dart';
import 'cartmodel.dart';


class ExploreApp extends StatefulWidget {
  const ExploreApp({super.key});
  @override
  State<ExploreApp> createState() => _ExploreAppState();
}



class _ExploreAppState extends State<ExploreApp> {
  final List<CartItem> cart = [];



  void addToCart(CartItem item) {
    setState(() {
      cart.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ice Cream App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: false,
        ),
      ),
      home: _MainShell(
        cart: cart,
        addToCart: addToCart,
      ),
    );
  }
}



class _MainShell extends StatefulWidget {
  final List<CartItem> cart;
  final void Function(CartItem) addToCart;


  const _MainShell({required this.cart, required this.addToCart});

  @override
  State<_MainShell> createState() => _MainShellState();
}


class _MainShellState extends State<_MainShell> with TickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController _fabAnimationController;
  late Animation<double> fabAnimation;

  late AnimationController _borderRadiusAnimationController;
  late Animation<double> borderRadiusAnimation;

  late AnimationController _revealController;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();

    // FAB animation
    _fabAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    fabAnimation = CurvedAnimation(
      parent: _fabAnimationController,
      curve: Curves.easeOutBack,
    );

    // Bottom nav border radius animation
    _borderRadiusAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _borderRadiusAnimationController,
        curve: Curves.fastOutSlowIn,
      ),
    );

    // Circular reveal controller
    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _revealAnimation = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeInOut,
    );

    // Initial animations
    Future.delayed(const Duration(milliseconds: 100), () {
      _fabAnimationController.forward();
      _borderRadiusAnimationController.forward();
      _revealController.forward();
    });
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    _borderRadiusAnimationController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    _revealController.reset();
    setState(() {
      _currentIndex = index;
    });
    _revealController.forward();
    _fabAnimationController
      ..reset()
      ..forward();
    _borderRadiusAnimationController
      ..reset()
      ..forward();
  }


  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      ExplorePage(addToCart: widget.addToCart),
      const _PlaceholderPage(title: 'Search'),
      const _PlaceholderPage(title: 'Notifications'),
      CartPage(cart: widget.cart),
    ];

    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: AnimatedBuilder(
          animation: _revealAnimation,
          builder: (context, child) {
            final radius = MediaQuery.of(context).size.longestSide * _revealAnimation.value;
            return ClipOval(
              clipper: _CircleRevealClipper(radius: radius),
              child: pages[_currentIndex],
            );
          },

        ),
      ),
      floatingActionButton: ScaleTransition(
        scale: fabAnimation,
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.brightness_3, color: primary),
          onPressed: () {
            _fabAnimationController
              ..reset()
              ..forward();
            _borderRadiusAnimationController
              ..reset()
              ..forward();
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBuilder(
        animation: borderRadiusAnimation,
        builder: (context, child) {
          return Container(
            margin: EdgeInsets.only(bottom: bottomInset),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(32 * borderRadiusAnimation.value),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 12,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final icons = [
                  Icons.home_outlined,
                  Icons.search,
                  Icons.notifications_none,
                  Icons.shopping_bag_outlined
                ];

                final selected = _currentIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onNavTap(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: selected ? primary.withOpacity(0.15) : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            icons[index],
                            color: selected ? primary : Colors.grey.shade600,
                            size: selected ? 28 : 24,
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );

        },
      ),
    );
  }
}

class _CircleRevealClipper extends CustomClipper<Rect> {
  final double radius;
  _CircleRevealClipper({required this.radius});

  final IconData icon;
  final int index;
  final int current;
  final ValueChanged<int> onTap;
  final Color highlightColor;

  @override
  bool shouldReclip(covariant _CircleRevealClipper oldClipper) {


    return radius != oldClipper.radius;
  }
}

class ExplorePage extends StatefulWidget {
  final void Function(CartItem) addToCart;
  const ExplorePage({super.key, required this.addToCart});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int _selectedCategory = 0;

  static const categories = [
    ('Cups', Icons.icecream),
    ('Rolls', Icons.waves),
    ('Sandwich', Icons.layers),
    ('Cakes', Icons.cake_outlined),
  ];

  final List<_Product> _popularCups = const [
    _Product(name: 'Mint Cup', asset: 'assets/images/mintcone.png', rating: 4.8, price: 5.75, description:'trtsets',  pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Blueberry Cup', asset: 'assets/images/blueberrycone.png', rating: 4.7, price: 5.50, description:'trtsets',  pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Caramel Cup', asset: 'assets/images/caramelcone.png', rating: 4.6, price: 6.00, description:'trtsets',  pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Oreo Cup', asset: 'assets/images/oreocone.png', rating: 4.5, price: 5.25, description:'trtsets',  pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Mixed Cup', asset: 'assets/images/mixedcone.png', rating: 4.9, price: 6.50, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
  ];

  final List<_Product> _popularRolls = const [
    _Product(name: 'Banana Rolls', asset: 'assets/images/bananarolls.png', rating: 4.9, price: 7.25, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Penutbutter Rolls', asset: 'assets/images/penubutterrolls.png', rating: 4.7, price: 6.75, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Bnanaberry Rolls', asset: 'assets/images/bananaberryrolls.png', rating: 4.8, price: 7.00, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Brownie Rolls', asset: 'assets/images/BrownieRolls.png', rating: 4.6, price: 6.50, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
  ];

  final List<_Product> _popularSandwich = const [
    _Product(name: 'Straberry Sandwich', asset: 'assets/images/strasandwitch.png', rating: 4.9, price: 8.25, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Pistachio Sandwich', asset: 'assets/images/pistachio1.png', rating: 4.8, price: 7.75, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Chocolate Sandwich', asset: 'assets/images/chocolate1.png', rating: 4.7, price: 8.00, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
  ];

  final List<_Product> _popularCakes = const [
    _Product(name: 'Oreo Cake', asset: 'assets/images/oreocake.png', rating: 4.8, price: 12.50, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Berries Cake', asset: 'assets/images/berriescake.png', rating: 4.7, price: 11.75, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Strawberry Cake', asset: 'assets/images/straberrycake.png', rating: 4.9, price: 13.00, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
  ];

  // Simple demo favorites. You can later wire this to real user choices.
  final List<_Product> _favoriteProducts = const [
    _Product(name: 'Pistachio Cup', asset: 'assets/images/oreocone.png', rating: 4.8, price: 5.25, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    _Product(name: 'Chocolate Sandwich', asset: 'assets/images/chocolate1.png', rating: 4.7, price: 8.00, description:'trtsets', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
  ];

  List<_Product> get _currentProducts {
    switch (_selectedCategory) {
      case 0: return _popularCups;
      case 1: return _popularRolls;
      case 2: return _popularSandwich;
      case 3: return _popularCakes;
      default: return _popularCups;
    }
  }

  String get _currentSectionTitle {
    switch (_selectedCategory) {
      case 0: return 'Popular Cups';
      case 1: return 'Popular Rolls';
      case 2: return 'Popular Sandwiches';
      case 3: return 'Popular Cakes';
      default: return 'Popular Cups';
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);

    final double bottomInset = MediaQuery.of(context).padding.bottom;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _Header(primary: primary),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 24),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 120,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                final (title, icon) = categories[index];
                final bool selected = index == _selectedCategory;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = index),
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(


                    color: selected ? primary.withAlpha(64) : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(


                       color: Colors.black.withAlpha(15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                      border: Border.all(color: selected ? primary : Colors.grey.shade200),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(icon, color: selected ? primary : Colors.grey.shade600, size: 35,),
                        const SizedBox(height: 4),
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            color: selected ? primary : Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _currentSectionTitle,
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Divider(
                      color: Colors.black.withOpacity(0.12),
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text('See all', style: TextStyle(color: primary, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 20),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 220,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final p = _currentProducts[index % _currentProducts.length];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(
                          product: Product(
                              name: p.name,
                        pricesBySize: p.pricesBySize,
                          image: p.asset,
                         description: p.description,
                         ),
                        addToCart: widget.addToCart,
                        ),
                      ),
                    );
                  },
                  child: _ProductCard(product: p),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemCount: _currentProducts.length,
            ),
          ),
        ),
        // Space before Your Favorites
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        // Your Favorites header with divider
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Row(
              children: [
                Text(
                  'Your Favorites',
                  style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 2),
                    child: Divider(
                      color: Colors.black.withOpacity(0.12),
                      thickness: 1,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        // Favorites horizontal list
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final p = _favoriteProducts[index % _favoriteProducts.length];
                return _ProductCard(product: p);
              },
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemCount: _favoriteProducts.length,
            ),
          ),
        ),
        // Spacer to keep content clear of bottom nav + gesture area
        SliverToBoxAdapter(
          child: SizedBox(height: kBottomNavigationBarHeight + bottomInset + 12),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.primary});

  final Color primary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 24, bottom: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 220,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.9),
              borderRadius: BorderRadius.circular(18),
            ),
          ),
          Positioned.fill(
            child: Row(
              children: [
                const SizedBox(width: 28),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('PICK YOUR',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1,
                          )),
                      Text(
                        'Favorite Choice',
                        style: GoogleFonts.pacifico(color: Colors.white, fontSize: 26),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),
          Positioned(
            right: -34,
            bottom: -32,
            child: SizedBox(
              height: 250,
              width: 280,
              child: Image.asset(
                'assets/images/strawberryyy1.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});

  final _Product product;

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);
    return Container(
      width: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(


           color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(product.asset, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              ...List.generate(5, (i) {
                final filled = product.rating - i >= 1;
                return Icon(
                  filled ? Icons.star : Icons.star_border,
                  color: primary,
                  size: 16,
                );
              }),
              const SizedBox(width: 6),
              Text(product.rating.toStringAsFixed(1),
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

class _Product {
  const _Product({
    required this.name,
    required this.asset,
    required this.rating,
    required this.price,
    this.description = '',
    required this.pricesBySize, // ← أضيفي required هنا
  });

  final String name;
  final String asset;
  final double rating;
  final double price;
  final String description;
  final Map<String, double> pricesBySize; // ← بدون ?
}

class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(title, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600)),
    );
  }
}
