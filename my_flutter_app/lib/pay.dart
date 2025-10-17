import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'cartmodel.dart';

class PayPage extends StatefulWidget {
  final List<CartItem> cart;

  const PayPage({super.key, required this.cart});

  @override
  State<PayPage> createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  bool saveCard = false;
  bool showOrderDetails = false;

  double get totalAmount {
    double total = 0;
    for (var item in widget.cart) {
      total += item.totalPrice;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    const Color primary = Color(0xFFecc6d5);
    const Color background = Color(0xFFF8F6F9);

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Payment Details"),
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          color: Colors.black87,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              _buildTextField("Cardholder Name", "Jenan Hasan",
                 ),
              const SizedBox(height: 20),
              _buildTextField(
                "Card Number",
                "2376 4567 7543 xxxx",
                suffixIcon: Icons.credit_card,
                suffixColor: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                      child: _buildTextField("Expiration Date", "08 / 29")),
                  const SizedBox(width: 16),
     Expanded(
  child: _buildTextField("Security Code", "***"),
),

                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: saveCard,
                    activeColor: primary,
                    onChanged: (val) {
                      setState(() => saveCard = val!);
                    },
                  ),
                  const Text("Save my card"),
                ],
              ),
              const SizedBox(height: 10),

              // Order Details Button
              GestureDetector(
                onTap: () {
                  setState(() {
                    showOrderDetails = !showOrderDetails;
                  });
                },
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Order Details",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Icon(showOrderDetails
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    ],
                  ),
                ),
              ),

              // قائمة المنتجات داخل Order Details
              if (showOrderDetails) ...[
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(
                    children: widget.cart.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text(
                              "${item.selectedSize} ${item.name} x${item.quantity}",
                              style: GoogleFonts.poppins(fontSize: 14),
                            )),
                            Text(
                              "${item.totalPrice.toStringAsFixed(2)} SAR",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600, fontSize: 14),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],

              const SizedBox(height: 20),
              Text(
                "By selecting the button below you confirm that you have read and accept Terms and Conditions.",
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 30),

              // Pay Button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Processing payment of ${totalAmount.toStringAsFixed(2)} SAR...")),

                                
                      );
                        ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                "Payment successful")),

                                
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "Pay ${totalAmount.toStringAsFixed(2)} SAR",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint,
      {IconData? suffixIcon, Color? suffixColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: const Color.fromARGB(255, 49, 49, 49),
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 6),
        TextField(
          style: const TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              color: const Color.fromARGB(221, 163, 163, 163),
              fontSize: 15,
            ),
            filled: true,
            fillColor: Colors.white,
            suffixIcon: suffixIcon != null
                ? Icon(suffixIcon, color: suffixColor, size: 20)
                : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: Color(0xFFecc6d5), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
