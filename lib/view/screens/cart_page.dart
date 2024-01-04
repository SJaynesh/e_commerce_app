import 'package:e_commerce/utills/product.dart';
import 'package:e_commerce/utills/routes.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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
            ? Container(
                alignment: Alignment.center,
                child: Text(
                  "No Data Available",
                  style: TextStyle(
                    fontSize: h * 0.025,
                  ),
                ),
              )
            : Column(
                children: [
                  ...addToCart
                      .map(
                        (e) => Container(
                          height: h * 0.178,
                          width: w,
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(h * 0.01),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['title'],
                                      style: TextStyle(
                                        fontSize: h * 0.025,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "⭐ (${e['rating']}) rating",
                                      style: TextStyle(
                                        fontSize: h * 0.02,
                                        color: const Color(0xff9A9998),
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "\$ ${e['price']}.00",
                                      style: TextStyle(
                                        fontSize: h * 0.023,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xffAA14F0),
                                      ),
                                    ),
                                    ActionChip(
                                      onPressed: () {
                                        setState(() {
                                          addToCart.remove(e);
                                        });
                                      },
                                      avatar: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      label: const Text(
                                        "Remove",
                                        style: TextStyle(
                                          color: Colors.red,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: w * 0.04,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        child: const Icon(Icons.add),
                                      ),
                                    ),
                                    Text(
                                      "0",
                                      style: TextStyle(
                                        fontSize: h * 0.025,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: CircleAvatar(
                                        radius: w * 0.04,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.3),
                                        child: const Icon(Icons.remove),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(h * 0.01),
                                    image: DecorationImage(
                                      image: NetworkImage(e['thumbnail']),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ],
              ),
      ),
      backgroundColor: const Color(0xeffafafa),
    );
  }
}
