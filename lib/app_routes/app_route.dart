import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:marketplace/error_screen.dart';
import 'package:marketplace/model/product_model.dart';
import 'package:marketplace/screens/forgot_password.dart';
import 'package:marketplace/screens/home_screen.dart';
import 'package:marketplace/screens/login_page.dart';
import 'package:marketplace/screens/myProfile.dart';
import 'package:marketplace/screens/pdetails.dart';
import 'package:marketplace/screens/product_image_picker.dart';

class RouteCon {
  static const home = 'home';
  static const login = 'login';
  static const profile = 'profile';
  static const addproduct = 'addproduct';
  static const productdetail = 'productdetail';
}

class AppRoutes {
  GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        name: RouteCon.home,
        path: "/",
        builder: (context, state) {
          return HomeScreen();
        },
        redirect: (context, state) async {
          User? firebaseUser = FirebaseAuth.instance.currentUser;

          if (firebaseUser != null) {
            return '/';
          } else {
            return '/login';
          }
        },
      ),
      GoRoute(
        name: RouteCon.login,
        path: "/login",
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        name: RouteCon.profile,
        path: "/profile",
        builder: (context, state) => Profile(),
      ),
      GoRoute(
        name: RouteCon.addproduct,
        path: "/addproducts",
        builder: (context, state) => ProductImagePicker(),
      ),
      GoRoute(
        name: RouteCon.productdetail,
        path: "/productdetail/view/:productId",
        builder: (context, state) {
          // Product sample = state.extra as Product;
          return Detail(
            pId: state.params['productId']!,
            // Product(
            //     name: state.params['name']!,
            //     date: state.params['date']!,
            //     description: state.params['description']!,
            //     img: state.params['img']!,
            //     location: state.params['location']!,
            //     price: state.params['price']!,
            //     productId: state.params['productId']!,
            //     signature: state.params['signature']!,
            //     userId: state.params['userId']!),
          );
        },
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
  );
}
