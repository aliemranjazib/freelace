// import 'package:go_router/go_router.dart';

// import 'package:marketplace/main.dart';
// import 'package:marketplace/model/product_model.dart';
// import 'package:marketplace/screens/pdetails.dart';
// import 'package:marketplace/screens/data_controller.dart';
// import 'package:marketplace/screens/complete_agreement_page.dart';
// import 'package:marketplace/screens/product_overview.dart';
// import 'package:marketplace/screens/product_image_picker.dart';
// import 'package:marketplace/screens/login_user_product_screen.dart';
// import 'package:marketplace/screens/login_page.dart';
// import 'package:marketplace/screens/home_screen.dart';
// import 'package:marketplace/screens/myProfile.dart';

// class RouteCon {
//   static const signtaurehome = 'signatureehome';
//   static const profile = 'profile';
//   static const marketplace = 'marketplace';
//   static const productDetails = 'productDetails';
//   static const addproducts = 'addproducts';
//   static const productOverview = 'productOverview';
// }

// class AppRoutes {
//   GoRouter router = GoRouter(debugLogDiagnostics: true, routes: [
//     GoRoute(
//       name: RouteCon.marketplace,
//       path: "/",
//       builder: (context, state) {
//         return HomeScreen();
//       },
//     ),
//     GoRoute(
//       name: RouteCon.signtaurehome,
//       path: "/addproducts",
//       builder: (context, state) {
//         return ProductImagePicker();
//       },
//     ),
//     GoRoute(
//       name: RouteCon.productDetails,
//       path: "/productDetails",
//       builder: (context, state) {
//         return Details(product);
//       },
//     ),
//     GoRoute(
//       name: RouteCon.productOverview,
//       path: "/productOverview",
//       builder: (context, state) {
//         return ProductOverview(product);
//       },
//     ),
//     GoRoute(
//       name: RouteCon.profile,
//       path: "/profile",
//       builder: (context, state) {
//         return Profile();
//       },
//     ),
//   ]);
// }
