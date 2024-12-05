import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'checkoutpage.dart';
import 'storepage.dart';


class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Your Cart'),
            IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Clear Cart'),
        content: Text('Are you sure you want to clear your cart?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              cart.clearCart(); // Clear the cart
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('Clear'),
          ),
        ],
      ),
    );
  },
),
          ],
        ),
      ),
      body: cart.cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100, // Adjust the size as needed
                    color: Colors.grey.shade400, // Matches the icon style
                  ),
                  SizedBox(height: 20), // Space between the icon and heading
                  Text(
                    'Your cart is currently empty.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24, // Large font size for the heading
                      fontWeight: FontWeight.bold, // Bold font for emphasis
                      color: Colors.black, // Adjust to your theme
                    ),
                  ),
                  SizedBox(height: 10), // Space between heading and description
                  Text(
                    'Before proceeding to checkout, you must add some products to your shopping cart. You will find a lot of interesting products in our shop page.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey, // Secondary text color
                      fontSize: 16, // Smaller font size for the description
                    ),
                  ),
                  SizedBox(height: 30), // Space between description and button
                  ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => StorePage()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange, // Button color
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Rounded button
    ),
    padding: EdgeInsets.symmetric(
      horizontal: 30, // Button width
      vertical: 12, // Button height
    ),
  ),
  child: Text(
    'RETURN TO STORE',
    style: TextStyle(
      color: Colors.white, // Button text color
      fontWeight: FontWeight.bold, // Bold button text
      fontSize: 16,
    ),
  ),
),

                ],
              ),
            )
          : ListView.builder(
              itemCount: cart.itemCount,
              itemBuilder: (context, index) {
                var item = cart.cartItems[index];
                return ListTile(
                  title: Text(item.title),
                  subtitle: Text('\$${item.price}'),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      cart.removeItem(item);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: cart.cartItems.isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Total price display
                  Text(
                    'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Checkout button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Checkout button color
                      padding: EdgeInsets.symmetric(
                        horizontal: 20, // Adjust button width
                        vertical: 12, // Adjust button height
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rounded button
                      ),
                    ),
                    child: Text(
                      'Checkout',
                      style: TextStyle(
                        color: Colors.white, // Text color
                        fontWeight: FontWeight.bold, // Bold text
                        fontSize: 16, // Font size
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
