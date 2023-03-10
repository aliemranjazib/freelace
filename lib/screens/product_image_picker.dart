import 'dart:convert';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firabase_storage;
import 'package:marketplace/screens/app_colors.dart';
import 'package:marketplace/screens/app_styles.dart';
import 'package:marketplace/screens/eco_button.dart';
import 'package:marketplace/screens/home_screen.dart';
import 'package:marketplace/screens/login_user_product_screen.dart';
import 'package:marketplace/screens/myProfile.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

import 'package:uuid/uuid.dart';

class ProductImagePicker extends StatefulWidget {
  @override
  State<ProductImagePicker> createState() => _ProductImagePickerState();
}

class _ProductImagePickerState extends State<ProductImagePicker> {
  bool _afternoonOutdoor = false;
  String caption_afternoon_outdoor = 'Afternoon Outdoor';

  _afternoonOutdoorChanged(bool value) =>
      setState(() => _afternoonOutdoor = value);

  bool valuefirst = false;
  bool valuesecond = false;
  final Size size = Get.size;
  int myIndex = 0;
  List<Widget> widgetList = [HomeScreen(), Profile()];
  String defaultImageUrl =
      'https://cdn.pixabay.com/photo/2016/03/23/15/00/ice-cream-1274894_1280.jpg';
  String selctFile = '';
  late XFile file;
  late Uint8List selectedImageInBytes;
  List<Uint8List> pickedImagesInBytes = [];
  List<String> imageUrls = [];
  int imageCounts = 0;
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemDescriptionController = TextEditingController();
  TextEditingController _itemPriceController = TextEditingController();
  TextEditingController _deviceTokenController = TextEditingController();
  TextEditingController _itemDateController = TextEditingController();
  TextEditingController _itemLocationController = TextEditingController();
  TextEditingController _itemSignatureController = TextEditingController();

  bool isItemSaved = false;

  bool isLoading = false;
  GlobalKey<SfSignaturePadState> key = GlobalKey();
  double min = 4.0;
  // Uuid? v;
  var uuid = Uuid();
  Uint8List? img;
  List<Color> colors = [Colors.black];
  Color? c;
  String idGenerator() {
    final now = DateTime.now();
    return now.microsecondsSinceEpoch.toString();
  }

  String signUrl = '';
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    //deleteVegetable();
    super.initState();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _itemPriceController.dispose();
    super.dispose();
  }

  _selectFile(bool imageForm) async {
    FilePickerResult? fileResult = await FilePicker.platform.pickFiles();

    if (fileResult != null) {
      setState(() {
        selctFile = fileResult.files.first.name;
        selectedImageInBytes = fileResult.files.first.bytes!;
      });
    }
  }

  Future<UploadTask?> uploadFile1(Uint8List? file) async {
    // idGenerator();
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No file was selected'),
        ),
      );

      return null;
    }

    UploadTask uploadTask;

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('signature')
        .child('/${idGenerator()}.jpg');

    final metadata = SettableMetadata(
      contentType: 'image/jpg',
      // customMetadata: {'picked-file-path': file},
    );

    uploadTask = ref.putData(file, metadata);
    await uploadTask.whenComplete(() => null);
    signUrl = await ref.getDownloadURL();

    setState(() {
      isLoading = true;
      isItemSaved = true;
    });
    String imageUrl = await _uploadFile();

    final User? user = auth.currentUser;
    final uid = user?.uid;
    var id = await FirebaseFirestore.instance.collection('productData').doc();
    await FirebaseFirestore.instance.collection('productData').add({
      'name': _itemNameController.text,
      'price': _itemPriceController.text,
      'description': _itemDescriptionController.text,
      'date': _itemDateController.text,
      'location': _itemLocationController.text,
      'signature': _itemSignatureController.text,
      'img': imageUrl,
      'user_Id': uid,
      'productId': uuid.v4(),
      'signUrl': signUrl
    }).then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Product Uploaded')));
      // sendPushMessage();
      setState(() {
        isItemSaved = false;
      });
      // Navigator.of(context).push(
      //     MaterialPageRoute(builder: ((context) => LoginUserProductScreen())));
    });

    return Future.value(uploadTask);
  }

  Future<String> _uploadFile() async {
    String imageUrl = '';
    try {
      firabase_storage.UploadTask uploadTask;

      firabase_storage.Reference ref = firabase_storage.FirebaseStorage.instance
          .ref()
          .child('test')
          .child('/' + selctFile);

      final metadata =
          firabase_storage.SettableMetadata(contentType: 'image/jpeg');

      // uploadTask = ref.putFile(File(file.path));
      uploadTask = ref.putData(selectedImageInBytes, metadata);

      // uploadTask = ref.putFile(File(file.path));
      uploadTask = ref.putData(selectedImageInBytes, metadata);

      await uploadTask.whenComplete(() => null);
      imageUrl = await ref.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return imageUrl;
  }

  saveItem() async {
    setState(() {
      isLoading = true;
      isItemSaved = true;
    });
    String imageUrl = await _uploadFile();

    // await _uploadMultipleFiles(_itemNameController.text);
    // print('Uploaded Image URL ' + imageUrls.length.toString());

    ///////////
    ui.Image image = await key.currentState!.toImage();
    final bytedata = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageBytes = bytedata!.buffer
        .asUint8List(bytedata.offsetInBytes, bytedata.lengthInBytes);
    String e = base64.encode(imageBytes);
    Uint8List decode = base64.decode(e);
    setState(() {
      img = decode;
    });
    uploadFile1(img);
    setState(() {
      isLoading = false;
    });

    // await _uploadMultipleFiles(_itemNameController.text);
    // print('Uploaded Image URL ' + imageUrls.length.toString());
    // final User? user = auth.currentUser;
    // final uid = user?.uid;
    // var id = await FirebaseFirestore.instance.collection('productData').doc();
    // await FirebaseFirestore.instance.collection('productData').add({
    //   'name': _itemNameController.text,
    //   'price': _itemPriceController.text,
    //   'description': _itemDescriptionController.text,
    //   'date': _itemDateController.text,
    //   'location': _itemLocationController.text,
    //   'signature': _itemSignatureController.text,
    //   'img': imageUrl,
    //   'user_Id': uid,
    //   'signUrl': signUrl
    // }).then((value) {
    //   // sendPushMessage();
    //   setState(() {
    //     isItemSaved = false;
    //   });
    //   Navigator.of(context).push(
    //       MaterialPageRoute(builder: ((context) => LoginUserProductScreen())));
    // });
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    bool showvalue;
    bool value;
    bool _checkbox = false;
    bool _checkboxListTile = false;
    bool isRememberMe;
    bool? _value = false;

    bool isChecked = false;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/eagree.png',
          fit: BoxFit.contain,
          height: 70,
          width: 60,
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: <Widget>[
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
              child: Text('Home')),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductImagePicker()));
              },
              child: Text('Add Product')),
          TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.hovered))
                      return Colors.blue.withOpacity(0.04);
                    if (states.contains(MaterialState.focused) ||
                        states.contains(MaterialState.pressed))
                      return Colors.blue.withOpacity(0.12);
                    return null; // Defer to the widget's default.
                  },
                ),
              ),
              onPressed: () {},
              child: Text('Profile')),
        ],
      ),
      backgroundColor: AppColors.backColor,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        15,
                      ),
                    ),
                    child: selctFile.isEmpty
                        ? Image.network(
                            defaultImageUrl,
                            fit: BoxFit.cover,
                          )

                        //==========================================//
                        : Image.memory(selectedImageInBytes)),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton.icon(
                  onPressed: () {
                    //_showPicker(context);
                    _selectFile(true);
                  },
                  icon: const Icon(
                    Icons.camera,
                  ),
                  label: const Text(
                    'Pick Image',
                    style: TextStyle(),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              if (isItemSaved)
                Container(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),

              Padding(
                padding: const EdgeInsets.only(right: 220, top: 20),
                child: Text(
                  'Product Name',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Product Name' : null;
                    },
                    controller: _itemNameController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Iphone 13',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),

              //==============================================//
              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Item Price',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Item Price' : null;
                    },
                    controller: _itemPriceController,
                    // onSaved: (value) {
                    //   productData['p_name'] = value!;
                    // },
                    // controller: _emailTextController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      // prefixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(AppIcons.emailIcon)),
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Iphone 13',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),

              //==============================================//
              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Description',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 90.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    minLines: 4, // <-- SEE HERE
                    maxLines: 10,
                    validator: (value) {
                      return value!.isEmpty
                          ? 'Product Description Required'
                          : null;
                    },
                    controller: _itemDescriptionController,
                    // onSaved: (value) {
                    //   productData['Description'] = value!;
                    // },
                    // controller: _emailTextController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      // prefixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(AppIcons.emailIcon)),
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Description',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text('Terms',
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.blueDarkColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  "By Listing you acknowledge the loperisum loperisum loperisum loperisum",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              //==============================================//

              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Enter Name',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Enter Name' : null;
                    },
                    controller: _itemDateController,
                    // onSaved: (value) {
                    //   productData['p_name'] = value!;
                    // },
                    // controller: _emailTextController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      // prefixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(AppIcons.emailIcon)),
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Enter Name',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Enter Date',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Enter Date' : null;
                    },
                    controller: _itemDateController,
                    // onSaved: (value) {
                    //   productData['p_name'] = value!;
                    // },
                    // controller: _emailTextController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      // prefixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(AppIcons.emailIcon)),
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Enter date',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Your Location',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  width: 325,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: AppColors.whiteColor,
                  ),
                  child: TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? 'Location' : null;
                    },
                    controller: _itemLocationController,
                    // onSaved: (value) {
                    //   productData['p_name'] = value!;
                    // },
                    // controller: _emailTextController,
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blueDarkColor,
                      fontSize: 12.0,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,

                      // prefixIcon: IconButton(
                      //     onPressed: () {},
                      //     icon: Image.asset(AppIcons.emailIcon)),
                      contentPadding:
                          const EdgeInsets.only(top: 5.0, left: 12.0),
                      hintText: 'Enter Location',
                      hintStyle: ralewayStyle.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.blueDarkColor.withOpacity(0.5),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 240, top: 20),
                child: Text(
                  'Signature',
                  textAlign: TextAlign.start,
                  style: ralewayStyle.copyWith(
                    fontSize: 12.0,
                    color: AppColors.blueDarkColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  width: 350,
                  child: SfSignaturePad(
                    key: key,
                    backgroundColor: Colors.grey.shade400,
                    strokeColor: c,
                    minimumStrokeWidth: 10,
                    maximumStrokeWidth: min,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),

              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text('Authorization / Fees',
                    style: ralewayStyle.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.blueDarkColor,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 300,
                child: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(),

              //====================================//
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 325,
                // child: ElevatedButton(
                //   child: const Text('Go to review page'),
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.blueDarkColor),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ReviewPage()),
                //     );
                //   },
                // ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                width: 325,
                // child: ElevatedButton(
                //   child: const Text('firestore'),
                //   style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.blueDarkColor),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => saveData()),
                //     );
                //   },
                // ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 325,
                child: ElevatedButton(
                  child: const Text('Your Product'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueDarkColor),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => LoginUserProductScreen()),
                    // );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 325,
                child: ElevatedButton(
                  child: const Text('All Product'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueDarkColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                width: 325,
                child: ElevatedButton(
                  child: const Text('Save'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueDarkColor),
                  onPressed: () {
                    saveItem();
                  },
                ),
              ),

              //==============================================//
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
