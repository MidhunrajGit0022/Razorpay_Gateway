import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Razor(),
    );
  }
}

class Razor extends StatefulWidget {
  const Razor({super.key});

  @override
  State<Razor> createState() => _RazorState();
}

class _RazorState extends State<Razor> {
  late Razorpay _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    Fluttertoast.showToast(msg: "Payment Success");
    log('Success: ${response.paymentId}');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    Fluttertoast.showToast(msg: "Payment Failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    // Fluttertoast.showToast(msg: "Payment Noooo");
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_E5bsDzF4ZtMy2D',
      'amount': 2000,
      'name': 'Bookz',
      'description': 'Ecommerce Application',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: OutlinedButton(
            onPressed: () {
              openCheckout();
            },
            child: const Text("Pay")),
      ),
    );
  }
}


//! For Web

// import 'package:flutter/material.dart';
// import 'package:razorpay_web/razorpay_web.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: Home(),
//     );
//   }
// }

// class Home extends StatefulWidget {
//   const Home({Key? key}) : super(key: key);

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late Razorpay razorpay;

//   @override
//   void initState() {
//     razorpay = Razorpay();
//     razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, errorHandler);
//     razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, successHandler);
//     razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, externalWalletHandler);
//     super.initState();
//   }

//   TextEditingController amountController = TextEditingController();
//   void errorHandler(PaymentFailureResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.message!),
//       backgroundColor: Colors.red,
//     ));
//   }

//   void successHandler(PaymentSuccessResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.paymentId!),
//       backgroundColor: Colors.green,
//     ));
//   }

//   void externalWalletHandler(ExternalWalletResponse response) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(response.walletName!),
//       backgroundColor: Colors.green,
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Razor pay")),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: amountController,
//               decoration: const InputDecoration(
//                 hintText: "Amount",
//                 focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.0)),
//                 enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.0)),
//                 disabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.grey, width: 0.0)),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           MaterialButton(
//             onPressed: () {
//               openCheckout();
//             },
//             child: const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 70, vertical: 15),
//               child: Text("Pay now"),
//             ),
//           ),
//         ],
//       )),
//     );
//   }

//   void openCheckout() {
//     var options = {
//       "key": "rzp_test_E5bsDzF4ZtMy2D",
//       "amount": num.parse(amountController.text) * 100,
//       "name": "test",
//       "description": " this is the test payment",
//       "timeout": "180",
//       "currency": "INR",
//       "prefill": {
//         "contact": "11111111111",
//         "email": "test@abc.com",
//       }
//     };
//     razorpay.open(options);
//   }
// }
