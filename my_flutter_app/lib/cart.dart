import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cartmodel.dart';
import 'pay.dart';



class CartPage extends StatefulWidget {
  final List<CartItem> cart;

  const CartPage({super.key, required this.cart});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: primary,
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: widget.cart.length,
              separatorBuilder: (_, __) => const SizedBox(height: 0), // ما بين المنتجات
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey, // الخط السفلي فقط
                        width: 0.5,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // صورة المنتج
                     // صورة المنتج مع خلفية رمادية
                 Container(
                width: 130,
               height: 130,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 245, 242, 242), 
                borderRadius: BorderRadius.circular(6),
  ),
               child: ClipRRect(
                   borderRadius: BorderRadius.circular(6),
                child: Image.asset(
                 item.imagePath,
                   fit: BoxFit.contain,
    ),
  ),
),

                      const SizedBox(width: 48),

                      // الاسم والوصف والكمية
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: GoogleFonts.nunito(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            if (item.description != null &&
                                item.description!.isNotEmpty)
                              Text(
                                item.description!,
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 12,
                                ),
                              ),
                            const SizedBox(height: 20),

                            // أدوات التحكم بالكمية
                           // أدوات التحكم بالكمية + السعر في نفس السطر
// أدوات التحكم بالكمية + السعر تحتها
Column(
  crossAxisAlignment: CrossAxisAlignment.start, // يخلي السعر يبدأ من نفس جهة الكمية
  children: [
    // أدوات التحكم بالكمية
    Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              if (item.quantity > 1) item.quantity--;
            });
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey.shade400,
              ),
            ),
            child: const Icon(Icons.remove, size: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              item.quantity++;
            });
          },
          child: Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: Color(0xFFecc6d5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, size: 16, color: Colors.white),
          ),
        ),
      ],
    ),

    const SizedBox(height: 20), // مسافة بسيطة بين الكمية والسعر

    // السعر تحت الكمية
    Text(
        '${item.totalPrice.toStringAsFixed(2)} SAR',
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 17,
      ),
    ),
  ],
),


                          ],
                        ),
                      ),

                      // السعر + زر الحذف
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              setState(() {
                                widget.cart.removeAt(index);
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${item.name} removed from cart'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
                
              },
              
            ),
            
                 // 🔘 زر الدفع العائم
  floatingActionButton: FloatingActionButton.extended(
  backgroundColor: primary,
  icon: const Icon(Icons.payment, color: Colors.white),
  label: const Text(
    'Proceed to Pay',
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
  onPressed: () {
 Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => PayPage(cart: widget.cart)),
);

  },
),
floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

    );
  }
}

