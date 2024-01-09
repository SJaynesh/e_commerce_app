import 'dart:developer';

import 'package:e_commerce/utills/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  bool isLike = false;

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // List images = data['images'];

    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Product Detail",
          style: TextStyle(
            fontSize: h * 0.025,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xeffafafa),
        actions: [
          const Icon(Icons.favorite_border_outlined),
          SizedBox(
            width: w * 0.025,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ...data['images']
                          .map(
                            (e) => Container(
                              height: h * 0.33,
                              width: w * 0.8,
                              margin: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(h * 0.045),
                                    bottomRight: Radius.circular(h * 0.045),
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 7,
                                      color: Colors.grey,
                                      offset: Offset(8, 8),
                                    )
                                  ],
                                  border: Border.all(),
                                  image: DecorationImage(
                                    image: NetworkImage(e),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['title'],
                            style: TextStyle(
                              fontSize: h * 0.025,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: h * 0.005,
                          ),
                          Text(
                            data['brand'],
                            style: TextStyle(
                              fontSize: h * 0.018,
                              color: Colors.grey,
                            ),
                          ),
                          RatingBarIndicator(
                            rating: double.parse(data['rating'].toString()),
                            itemSize: h * 0.03,
                            itemCount: 5,
                            direction: Axis.horizontal,
                            textDirection: TextDirection.ltr,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star_outlined,
                              color: Color(0xffFFB001),
                            ),
                          ),
                          // RatingBar.builder(
                          //   allowHalfRating: true,
                          //   itemBuilder: (context, index) => Icon(
                          //     Icons.favorite,
                          //     color: Colors.green,
                          //   ),
                          //   onRatingUpdate: (val) {
                          //     log("$val");
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "\$ ${data['price']}.00",
                            style: TextStyle(
                              fontSize: h * 0.025,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffAA14F0),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About",
                      style: TextStyle(
                        fontSize: h * 0.023,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    Text(
                      data['description'],
                      style: const TextStyle(
                        color: Color(0xff7A7A7A),
                      ),
                    ),
                    SizedBox(
                      height: h * 0.025,
                    ),
                    ActionChip(
                      avatar: (likedProducts.contains(Product.indexOf(data)))
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_border),
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(h * 0.008),
                      ),
                      label: (!likedProducts.contains(Product.indexOf(data)))
                          ? const Text("Like")
                          : const Text("UnLike"),
                      onPressed: () {
                        int index = Product.indexOf(data);
                        log("$index");

                        likedProducts.contains(index)
                            ? likedProducts.remove(index)
                            : likedProducts.add(index);

                        log("${likedProducts}");
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
              Ink(
                decoration: BoxDecoration(
                  color: const Color(0xffAA14F0),
                  borderRadius: BorderRadius.circular(h * 0.035),
                ),
                child: InkWell(
                  splashColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(h * 0.035),
                  onTap: () {
                    if (!addToCart.contains(data)) {
                      addToCart.add(data);
                    }
                    log(" ------ Add To Cart ------");
                    log("${addToCart}");
                    log("${addToCart.length}");
                    log("---------------------------");
                  },
                  child: Container(
                    height: h * 0.06,
                    width: w,
                    alignment: Alignment.center,
                    child: const Text(
                      "ADD TO CART",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color(0xeffafafa),
    );
  }
}
