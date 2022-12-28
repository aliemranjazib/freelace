// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:get/get.dart';
// import 'package:marketplace/model/product_model.dart';
// import 'package:marketplace/screens/TnC.dart';
// import 'package:marketplace/screens/data_controller.dart';
// import 'package:marketplace/screens/home_screen.dart';
// import 'package:marketplace/screens/pdetails.dart';
// import 'package:marketplace/screens/privacy.dart';
// import 'package:marketplace/screens/product_image_picker.dart';
// import 'package:marketplace/screens/user_agreement.dart';

// class LoginUserProductScreen extends StatelessWidget {
//   LoginUserProductScreen({super.key});

//   final DataController controller = Get.put(DataController());

//   final editPriceValue = TextEditingController();
//   final Size size = Get.size;

//   editProduct(productID, price) {
//     editPriceValue.text = price.toString();
//     Get.bottomSheet(
//       ClipRRect(
//         child: Container(
//           color: Colors.white,
//           height: 200,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 TextFormField(
//                   decoration: InputDecoration(labelText: "Enter new price"),
//                   controller: editPriceValue,
//                 ),
//                 SizedBox(
//                   height: 50,
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     Get.back();
//                     controller.editProduct(productID, editPriceValue.text);
//                   },
//                   child: Text('Submit'),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       controller.getLoginUserProduct();
//     });

//     return Scaffold(
//         appBar: AppBar(
//           title: Image.asset(
//             'assets/images/eagree.png',
//             fit: BoxFit.contain,
//             height: 70,
//             width: 60,
//           ),
//           backgroundColor: Color.fromARGB(255, 255, 255, 255),
//           actions: <Widget>[
//             TextButton(
//                 style: ButtonStyle(
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                     (Set<MaterialState> states) {
//                       if (states.contains(MaterialState.hovered))
//                         return Colors.blue.withOpacity(0.04);
//                       if (states.contains(MaterialState.focused) ||
//                           states.contains(MaterialState.pressed))
//                         return Colors.blue.withOpacity(0.12);
//                       return null; // Defer to the widget's default.
//                     },
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => HomeScreen()));
//                 },
//                 child: Text('Home')),
//             TextButton(
//                 style: ButtonStyle(
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                     (Set<MaterialState> states) {
//                       if (states.contains(MaterialState.hovered))
//                         return Colors.blue.withOpacity(0.04);
//                       if (states.contains(MaterialState.focused) ||
//                           states.contains(MaterialState.pressed))
//                         return Colors.blue.withOpacity(0.12);
//                       return null; // Defer to the widget's default.
//                     },
//                   ),
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => ProductImagePicker()));
//                 },
//                 child: Text('Add Product')),
//             TextButton(
//                 style: ButtonStyle(
//                   foregroundColor:
//                       MaterialStateProperty.all<Color>(Colors.blue),
//                   overlayColor: MaterialStateProperty.resolveWith<Color?>(
//                     (Set<MaterialState> states) {
//                       if (states.contains(MaterialState.hovered))
//                         return Colors.blue.withOpacity(0.04);
//                       if (states.contains(MaterialState.focused) ||
//                           states.contains(MaterialState.pressed))
//                         return Colors.blue.withOpacity(0.12);
//                       return null; // Defer to the widget's default.
//                     },
//                   ),
//                 ),
//                 onPressed: () {},
//                 child: Text('Profile')),
//           ],
//         ),
//         body: GetBuilder<DataController>(
//           builder: (controller) => controller.loginUserData.isEmpty
//               ? Center(
//                   child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
//                 )
//               : ListView.builder(
//                   itemCount: controller.loginUserData.length,
//                   itemBuilder: (context, index) {
//                     Product product = controller.loginUserData[index];
//                     return InkWell(
//                       onTap: () {
//                         controller.loginUserData[index];
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => Details(product)));
//                       },
//                       child: Card(
//                         child: Column(
//                           children: [
//                             Container(
//                               height: 300,
//                               width: 400,
//                               // height: MediaQuery.of(context).size.height * 0.35,
//                               // width: MediaQuery.of(context).size.width * 0.3,
//                               child: Image.network(
//                                 controller.loginUserData[index].img,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   Text(
//                                     "Product Name: ${controller.loginUserData[index].name}",
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                   Text(
//                                     'Price: ${controller.loginUserData[index].price.toString()}',
//                                     style:
//                                         TextStyle(fontWeight: FontWeight.bold),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceAround,
//                                 children: [
//                                   // ElevatedButton(
//                                   //   onPressed: () {
//                                   //     editProduct(
//                                   //         controller
//                                   //             .loginUserData[index].productId,
//                                   //         controller.loginUserData[index].price);
//                                   //   },
//                                   //   child: Text('Edit'),
//                                   // ),
//                                   ElevatedButton(
//                                     onPressed: () {
//                                       controller.deleteProduct(controller
//                                           .loginUserData[index].productId);
//                                     },
//                                     child: Text('Delete'),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//         ),
//         bottomNavigationBar: Container(
//           height: size.height / 14,
//           width: size.width,
//           color: Color.fromARGB(255, 19, 38, 94),
//           child: Row(
//             children: <Widget>[
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 19, 38, 94)),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Terms()));
//                 },
//                 child: Text(
//                   'Term and Conditions',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Spacer(),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 19, 38, 94)),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => Privacy()));
//                 },
//                 child: Text(
//                   'Privacy',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//               Spacer(),
//               ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Color.fromARGB(255, 19, 38, 94)),
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => UserAgreement()));
//                 },
//                 child: Text(
//                   'User Licence Agreement',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ));
//   }
// }
