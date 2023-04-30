import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/Database/product_db.dart';
import 'package:flutter_ecommerce/bloc/ecommerce/eccomerce_state.dart';
import 'dart:io';
import '../../Database/dbhelper.dart';
import 'ecommerce_add_to_cart.dart';
import 'ecommerce_cubit.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // String base64Image = base64Encode(imageBytes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Mall'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Product_Cart()));
              },
              icon: Icon(
                Icons.add_shopping_cart,
                color: Colors.white,
                size: 32,
              ))
        ],
      ),
      body: BlocBuilder<EcommerceCubit, EcommerceState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ErrorState) {
            return Center(
              child: Icon(Icons.close),
            );
          } else if (state is LoadedState) {
            final product = state.product;

            return OrientationBuilder(
              builder: (context, orientation) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: product.length,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      width: 335,
                      // height: 175,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 335,
                              height: 110,
                              child: Image.network(
                                product[index].featuredImage,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(child: Text(product[index].title)),
                                  IconButton(
                                      onPressed: () async {
                                        final imgBase64Str =
                                            await networkImageToBase64(
                                                product[index].featuredImage);
                                        await DatabaseHelper.insertProfile(
                                            Products_DB(
                                                    title: product[index].title,
                                                    price: product[index]
                                                        .price
                                                        .toString(),
                                                    featuredImage: imgBase64Str)
                                                .toMap());
                                      },
                                      icon: Icon(Icons.add_shopping_cart))
                                ])
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Future<String?> networkImageToBase64(String imageUrl) async {
    http.Response response = await http.get(Uri.parse(imageUrl));
    final bytes = response?.bodyBytes;
    return (bytes != null ? base64Encode(bytes) : null);
  }
}
