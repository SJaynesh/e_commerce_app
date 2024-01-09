import 'package:e_commerce/utills/product.dart';
import 'package:e_commerce/utills/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double discount = 0.0;
  double totalPrice = 0.0;

  calculateBill() {
    totalPrice = 0.0;
    addToCart.forEach((element) {
      discount =
          (element['price'] * (element['discountPercentage'] ?? 0.0)) / 100;
      totalPrice += (element['price'] - discount) * element['qty'];
    });
  }

  @override
  void initState() {
    super.initState();
    calculateBill();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cart",
          style: TextStyle(
            fontSize: h * 0.025,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xeffafafa),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  GlobalRoutes.home_page, (route) => false);
            },
            icon: const Icon(Icons.home_filled),
          ),
          SizedBox(
            width: w * 0.025,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: (addToCart.isEmpty)
            ? Center(
                child: Image.asset("assets/images/cart_page/no_data.png"),
              )
            : Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ...addToCart
                              .map(
                                (e) => Slidable(
                                  endActionPane: ActionPane(
                                    motion: const BehindMotion(),
                                    children: [
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(20),
                                        icon: Icons.info,
                                        onPressed: (context) {},
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SlidableAction(
                                        borderRadius: BorderRadius.circular(20),
                                        icon: Icons.delete,
                                        foregroundColor: Colors.red,
                                        onPressed: (context) {
                                          setState(() {
                                            addToCart.remove(e);
                                          });
                                        },
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     setState(() {
                                      //       int index = addToCart.indexOf(e);
                                      //       addToCart.removeAt(index);
                                      //     });
                                      //   },
                                      //   child: Container(
                                      //     height: h * 0.17,
                                      //     width: w * 0.2,
                                      //     decoration: BoxDecoration(
                                      //       color: const Color(0xffF2F2F2),
                                      //       borderRadius:
                                      //           BorderRadius.circular(h * 0.015),
                                      //     ),
                                      //     child: Column(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         const Icon(
                                      //           Icons.delete,
                                      //           color: Colors.red,
                                      //         ),
                                      //         SizedBox(
                                      //           height: h * 0.025,
                                      //         ),
                                      //         Text(
                                      //           "Remove",
                                      //           style: TextStyle(
                                      //             color: Colors.red,
                                      //             fontSize: h * 0.018,
                                      //             fontWeight: FontWeight.w500,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                  child: Container(
                                    height: h * 0.178,
                                    width: w,
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(h * 0.01),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  e['title'],
                                                  style: TextStyle(
                                                    fontSize: h * 0.025,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "⭐ (${e['rating']}) rating",
                                                  style: TextStyle(
                                                    fontSize: h * 0.02,
                                                    color:
                                                        const Color(0xff9A9998),
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "\$ ${e['price']}.00",
                                                  style: TextStyle(
                                                    fontSize: h * 0.023,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        const Color(0xffAA14F0),
                                                  ),
                                                ),
                                              ),
                                              // ActionChip(
                                              //   onPressed: () {
                                              //     setState(() {
                                              //       addToCart.remove(e);
                                              //     });
                                              //   },
                                              //   avatar: const Icon(
                                              //     Icons.delete,
                                              //     color: Colors.red,
                                              //   ),
                                              //   label: const Text(
                                              //     "Remove",
                                              //     style: TextStyle(
                                              //       color: Colors.red,
                                              //       letterSpacing: 0.5,
                                              //     ),
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (e['qty'] < e['stock']) {
                                                      e['qty']++;
                                                    }
                                                    calculateBill();
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: w * 0.04,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.3),
                                                  child: const Icon(Icons.add),
                                                ),
                                              ),
                                              Text(
                                                "${e['qty']}",
                                                style: TextStyle(
                                                  fontSize: h * 0.025,
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    if (e['qty'] > 1) {
                                                      e['qty']--;
                                                    } else {
                                                      addToCart.remove(e);
                                                    }

                                                    calculateBill();
                                                  });
                                                },
                                                child: CircleAvatar(
                                                  radius: w * 0.04,
                                                  backgroundColor: Colors.grey
                                                      .withOpacity(0.3),
                                                  child:
                                                      const Icon(Icons.remove),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      h * 0.01),
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    e['thumbnail']),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: h * 0.3,
                      width: w,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(h * 0.012),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Selected Item : ${addToCart.length}",
                                style: TextStyle(
                                  fontSize: MediaQuery.of(context)
                                      .textScaler
                                      .scale(24),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Total price: ${totalPrice.toString().split('.')[0]}.${totalPrice.toString().split('.')[1][0]}${totalPrice.toString().split('.')[1][1]}",
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).textScaler.scale(24),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: const Color(0xeffafafa),
    );
  }
}
