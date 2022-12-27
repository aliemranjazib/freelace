import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  Future<void> addNewProduct(Map productdata) async {
    // var pathimage = image.toString();
    // var temp = pathimage.lastIndexOf('/');
    // var result = pathimage.substring(temp + 1);
    // print(result);
    // final ref =
    // FirebaseStorage.instance.ref().child('product_images').child(result);
    // var response = await ref.putFile(image);
    // print("Updated $response");
    // var imageUrl = await ref.getDownloadURL();

    try {
      // CommDi.showLoading();
      var response =
          await FirebaseFirestore.instance.collection('products').add({
        'name': productdata['p_name'],
        'price': productdata['p_price'],
        // "product_upload_date": productdata['p_upload_date'],
        // 'product_image': imageUrl,
        // 'user_Id': authController.userId,
        // "phone_number": productdata['phone_number'],
      });
      print("Firebase response1111 $response");
      // CommanDialog.hideLoading();
      Get.back();
    } catch (exception) {
      // CommanDialog.hideLoading();
      print("Error Saving Data at firestore $exception");
    }
  }
}
