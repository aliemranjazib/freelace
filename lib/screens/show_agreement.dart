import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marketplace/model/Agreement.dart';
import 'package:marketplace/model/product_model.dart';
import 'package:marketplace/screens/TnC.dart';
import 'package:marketplace/screens/data_controller.dart';
import 'package:marketplace/screens/home_screen.dart';
import 'package:marketplace/screens/login_user_product_screen.dart';
import 'package:marketplace/screens/privacy.dart';
import 'package:marketplace/screens/product_image_picker.dart';
import 'package:marketplace/screens/product_overview.dart';
import 'package:marketplace/screens/save_pdf.dart';
import 'package:marketplace/screens/user_agreement.dart';
import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

class ShowAgreement extends StatelessWidget {
  late final Agreement agreement;
  ShowAgreement(this.agreement);

  @override
  Widget build(BuildContext context) {
    final Size size = Get.size;
    // final controller = Get.put(ItemDetailController());

    // controller.getItemDetails(id);

    return Container(
      color: Color(0xff252B5C),
      child: SafeArea(
        child: GetBuilder<DataController>(builder: (value) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Product'),
                backgroundColor: Color(0xff252B5C),
                actions: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff252B5C),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    },
                    child: Text('Home'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff252B5C),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductImagePicker()));
                    },
                    child: Text('Add Product'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff252B5C),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => LoginUserProductScreen()));
                    },
                    child: Text('Your Product'),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff252B5C),
                      ),
                      onPressed: () {},
                      child: Text('Profile'))
                ],
              ),
              body: SizedBox(
                height: size.height,
                width: size.width,
                child: SingleChildScrollView(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height / 3.5,
                          width: size.width,
                          child: PageView.builder(
                            //s itemCount: pr.length,
                            //onPageChanged: controller.changeIndicator,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(agreement.img),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // indicator

                        SizedBox(
                          height: size.height / 25,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // children: [
                            //   for (int i = 0;
                            //       i < product.;
                            //       i++)
                            //     indicator(size, false)
                            // ],
                          ),
                        ),

                        SizedBox(
                          height: size.height / 25,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: Text(
                            agreement.name,
                            style: const TextStyle(
                              fontSize: 24,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height / 35,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: RichText(
                            text: TextSpan(
                              text: "${agreement.price}",
                              style: const TextStyle(
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.lineThrough),
                              children: [
                                TextSpan(
                                  text: " ${agreement.price}",
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.grey[800],
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                                TextSpan(
                                  // text: " ${product.price}% off",
                                  style: const TextStyle(
                                    fontSize: 19,
                                    color: Colors.green,
                                    decoration: TextDecoration.none,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height / 25,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: const Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height / 50,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: Text(
                            agreement.description,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: const Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height / 80,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: Text(
                            agreement.location,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height / 25,
                        ),
                        SizedBox(
                          width: size.width / 1.2,
                          child: const Text(
                            "Date",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(
                          height: size.height / 80,
                        ),

                        SizedBox(
                          width: size.width / 1.2,
                          child: Text(
                            agreement.date,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        // ListTile(
                        //   onTap: () {},
                        //   title: Text("See Reviews"),
                        //   trailing: Icon(Icons.arrow_forward_ios),
                        //   leading: Icon(Icons.star),
                        // ),

                        SizedBox(
                          height: size.height / 100,
                        ),
                        SizedBox(
                          height: size.height / 14,
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: customButtom(size, () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SaveBtnBuilder(agreement)));
                                }, Colors.white, "Export"),
                              ),
                              // ElevatedButton(
                              //     onPressed: () {
                              //       printff();
                              //     },
                              //     child: Text('Exportttt'))
                            ],
                          ),
                        )
                      ]),
                ),
              ),

              // bottomNavigationBar: SizedBox(
              //   height: size.height / 14,
              //   width: size.width,
              //   child: Row(
              //     children: [
              //       // Expanded(
              //       //   child: customButtom(
              //       //     size,
              //       //     () {
              //       //       // if (controller.isAlreadyAvailable) {
              //       //       //   Get.to(() => CartScreen());
              //       //       // } else {
              //       //       //   controller.addItemsToCart();
              //       //       // }
              //       //     },
              //       //     Colors.redAccent,
              //       //     // product.isAlreadyAvailable
              //       //         ? "Go to Cart"
              //       //         : "Add to Cart",
              //       //   ),
              //       // ),
              //       Expanded(
              //         child: customButtom(size, () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ProductOverview(product)));
              //         }, Colors.white, "Buy Now"),
              //       ),
              //     ],
              //   ),
              // ),
              bottomNavigationBar: Container(
                height: size.height / 14,
                width: size.width,
                color: Color.fromARGB(255, 19, 38, 94),
                child: Row(
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 19, 38, 94)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Terms()));
                      },
                      child: Text(
                        'Term and Conditions',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 19, 38, 94)),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Privacy()));
                      },
                      child: Text(
                        'Privacy',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 19, 38, 94)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserAgreement()));
                      },
                      child: Text(
                        'User Licence Agreement',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ));
        }),
      ),
    );
  }

  Widget customButtom(Size size, Function function, Color color, String title) {
    return GestureDetector(
      onTap: () => function(),
      child: Container(
        alignment: Alignment.center,
        color: color,
        child: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            color: color == Colors.redAccent ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget indicator(Size size, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: isSelected ? size.height / 80 : size.height / 100,
        width: isSelected ? size.height / 80 : size.height / 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
        ),
      ),
    );
  }
}

void printff() async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Text('Hello World!'),
      ),
    ),
  );

  final file = File('example.pdf');
  await file.writeAsBytes(await pdf.save());
}

// Future<void> printffn() async {
//   final pdf = pw.Document();

//   pdf.addPage(
//     pw.Page(
//       build: (pw.Context context) => pw.Center(
//         child: pw.Text('Hello World!'),
//       ),
//     ),
//   );

//   final file = File('example.pdf');
//   await file.writeAsBytes(await pdf.save());
// }
