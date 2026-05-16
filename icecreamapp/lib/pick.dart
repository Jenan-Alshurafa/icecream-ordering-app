import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'cartmodel.dart';

class ProductDetailPage extends StatefulWidget {
 final Product product;
 final void Function(CartItem) addToCart;
  
  const ProductDetailPage({
    super.key,
    required this.product,
    required this.addToCart,
  });



  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  // State variables for the product detail page
  String selectedSize = 'S'; // S, M, L
  int quantity = 1;
  double totalPrice = 0; // ← هنا تعريف متغير السعر كحالة
  bool isFavorite = false;
  
  @override
void initState() {
  super.initState();
  totalPrice = widget.product.getPrice(selectedSize) * quantity;
}

void updateTotalPrice() {
  setState(() {
    totalPrice = widget.product.getPrice(selectedSize) * quantity;
  });
}


  // Product data - now comes from the widget parameters
  
  // Related products data
  final List<Product> products = const [
    Product(name: 'Mint Cup', image: 'assets/images/mintcone.png',description: 'teststst', pricesBySize: {'S': 5.75, 'M': 7.75, 'L': 9.75},),
    Product(name: 'Brownie Rolls', image: 'assets/images/BrownieRolls.png',description: 'testt', pricesBySize: {'S': 6.50, 'M': 8.50, 'L': 10.50},),
    Product(name: 'Straberry Sandwich', image: 'assets/images/strasandwitch.png' ,description: 'uygfeygc', pricesBySize: {'S': 8.25, 'M': 10.25, 'L': 12.25},),
    Product(name: 'Chocolate Sandwich', image: 'assets/images/chocolate1.png',description: 'uygfeygc', pricesBySize: {'S': 8.00, 'M': 10.00, 'L': 12.00},),
    Product(name: 'Oreo Cake', image: 'assets/images/oreocake.png',description: 'uygfeygc', pricesBySize: {'S': 12.50, 'M': 14.50, 'L': 14.50},),
    Product(name: 'Berries Cake', image: 'assets/images/berriescake.png',description: 'uygfeygc', pricesBySize: {'S': 11.75, 'M': 13.75, 'L': 15.75},),
    Product(name: 'Strawberry Cake', image: 'assets/images/straberrycake.png',description: 'uygfeygc', pricesBySize: {'S': 13.00, 'M': 15.00, 'L': 17.00},),
    Product(name: 'Pistachio Sandwich',  image: 'assets/images/pistachio1.png',description: 'uygfeygc', pricesBySize: {'S': 7.75, 'M': 9.75, 'L': 11.75},),
    Product(name: 'Berries Cake', image: 'assets/images/berriescake.png',description: 'uygfeygc', pricesBySize: {'S': 11.75, 'M': 13.75, 'L': 15.75},),
    Product(name: 'Banana Rolls',  image:'assets/images/bananarolls.png' , description: 'description', pricesBySize: {'S': 7.25, 'M': 9.25, 'L': 11.25},),
    Product(name: 'Bananaberry Rolls',  image: 'assets/images/bananaberryrolls.png', description: 'uygfeygc', pricesBySize: {'S': 7.00, 'M': 9.00, 'L': 11.00},),
    Product(name: 'Blueberry Cup',  image: 'assets/images/blueberrycone.png', description: 'description', pricesBySize: {'S': 5.50, 'M': 7.50, 'L': 9.50},),
    Product(name: 'Caramel Cup',  image: 'assets/images/blueberrycone.png', description: 'description', pricesBySize: {'S': 6.00, 'M': 8.00, 'L': 10.00},),
    Product(name: 'Mixed Cup',  image:'assets/images/blueberrycone.png' , description: 'description', pricesBySize: {'S': 6.50, 'M': 8.50, 'L': 10.50},),
    Product(name: 'Oreo Cup',  image: 'assets/images/oreocone.png', description: 'uygfeygc', pricesBySize: {'S': 5.25, 'M': 7.20, 'L': 9.25},),
    Product(name: 'Penutbutter Rolls',  image: 'assets/images/penubutterrolls.png', description: 'uygfeygc', pricesBySize: {'S': 6.75, 'M': 8.75, 'L': 10.75},)

  ];

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);
    
    // Calculate total price based on quantity


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Navigation Bar
              _buildTopBar(),
              
              // Main Content - Two Column Layout
              _buildMainContent(primary),
              
              // Related Products Section
              _buildRelatedProducts(),
              
              // Bottom spacing
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // Main content with two-column layout
  Widget _buildMainContent(Color primary) {
    final int randomCalories = Random().nextInt(1000) + 100;
    final int randomSugar = Random().nextInt(10) + 3;
    final int randomCalcium = Random().nextInt(10) + 1;
    final int randomEnergy = Random().nextInt(1000) + 100;
 final int mainRating = Random().nextInt(5) + 2;


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Column - Text Information
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Title and Price
                Text(
                  widget.product.name,
                  style: GoogleFonts.pacifico(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
             Text(
'Total : ${totalPrice.toStringAsFixed(2)} SAR',
  style: GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: Colors.black87,
  ),
),

                const SizedBox(height: 24),
                
                // Nutritional Information
                Text(
                  '$randomEnergy kcal Energy',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$randomCalories kcal Calories',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$randomCalcium % Calcium',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$randomSugar g Sugar',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 24),
                
                // Product Description
                Text(
                  widget.product.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: const Color.fromARGB(255, 0, 0, 0),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                // total and rating
                Row(
               children: [
 
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(5, (starIndex) {
        return Icon(
          starIndex < mainRating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 30,
        );
      }),
    ),    
  ],
),

                 const SizedBox(height: 50),
                // Action Buttons
                Row(
                  children: [
                    // Favorite button
                    GestureDetector(
                      onTap: () => setState(() => isFavorite = !isFavorite),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                   // Add to cart button
Expanded(
  child: GestureDetector(
    onTap: () {
      widget.addToCart(
       CartItem(
  name: widget.product.name,
  pricesBySize: widget.product.pricesBySize, // تمرير Map الأسعار
  imagePath: widget.product.image,
  quantity: quantity,
  selectedSize: selectedSize, // الحجم الذي اختاره المستخدم
)

      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${widget.product.name} added to cart!'),
        duration: Duration(seconds: 1 ),
        ),
        
      );
    },
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: primary,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Center(
        child: Text(
          'Add To Cart',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    ),
  ),
),

                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 20),
          
          // Right Column - Image and Controls
          Expanded(
            flex: 1,
            child: _buildRightColumn(primary),
          ),
        ],
      ),
    );
  }

  // Right column with image and controls
  Widget _buildRightColumn(Color primary) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
         color: primary.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Product Image - Circular Plate
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 200,
                height: 190,
                decoration: BoxDecoration(
                ),
                child: ClipOval(
                  child: Image.asset(
                    widget.product.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          
          // Size Selection
          Positioned(
            bottom: 120,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Size',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: ['S', 'M', 'L'].map((size) {
                    bool isSelected = selectedSize == size;
                    return GestureDetector(
                  onTap: () {
  setState(() {
    selectedSize = size;
  });
  updateTotalPrice();
},

                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected ? primary : Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? primary : Colors.grey.shade300,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            size,
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.grey.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          
          // Quantity Selector
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Qty',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                     if (quantity > 1) {
  setState(() {
    quantity--;
  });
  updateTotalPrice();
}

                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Icon(Icons.remove, size: 16, color: Colors.grey.shade700),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                       onTap: () {
                        setState(() {
  quantity++;
});
updateTotalPrice();

                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          color: primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Top navigation bar with back button and menu
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              children: [
                Icon(Icons.arrow_back, color: Colors.grey.shade700),
                const SizedBox(width: 8),
                Text('Back', style: TextStyle(color: Colors.grey.shade700)),
              ],
            ),
          ),
          Icon(Icons.menu, color: Colors.grey.shade700),
        ],
      ),
    );
  }


  // Related products section
  Widget _buildRelatedProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            'People also like',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 140,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      child: ClipOval(
                        child: Image.asset(
                          product.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.pricesBySize['S']}SAR',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Related product data model
class Product {
  final Map<String, double> pricesBySize;
  final String name;
  final String image;
  final String description;


  const Product({
    required this.pricesBySize,
    required this.name,
    required this.image,
    required this.description,
  });
  
  double getPrice(String size) {
  if (pricesBySize.containsKey(size)) {
    return pricesBySize[size]!;
  } else {
    return 0;
  }
}


}