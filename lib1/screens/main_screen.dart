import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:marketplace/model/user.dart';
import 'package:marketplace/screens/data_controller.dart';
import 'package:marketplace/screens/product_image_picker.dart';

// import '../model/book.dart';

class MainScreenPage extends StatelessWidget {
  const MainScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('users');
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white24,
          elevation: 0.0,
          centerTitle: false,
          title: Row(
            children: [
              Text(
                'Marketplace',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            StreamBuilder<QuerySnapshot>(
                stream: userCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // final userListStream = snapshot.data?.docs.map((users) {
                  //   return MUser.fromDocument(users);
                  // },).where(((user) {
                  //   return (user.uid == FirebaseAuth.instance.currentUser?.uid);
                  // })).toList();

                  // MUser curUser = userListStream![0];

                  return Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://picsum.photos/id/1/200/300'),
                          backgroundColor: Colors.white,
                          child: Text(''),
                        ),
                      ),
                      Text(
                        'curUser.displayName',
                        style: TextStyle(color: Colors.black12),
                      )
                    ],
                  );
                }),
            TextButton.icon(
                onPressed: () {}, icon: Icon(Icons.logout), label: Text(''))
          ],
        ),
        body: Container(
          alignment: Alignment.center,
          child: const SizedBox(
            width: 350,
            child: MyCustomForm(),
          ),
        ));
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> productData = {
    "p_name": "",
    "p_price": "",
    // "p_upload_date": DateTime.now().millisecondsSinceEpoch,
    // "phone_number": ""
  };

  addProduct() {
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      print("Form is vaid ");
      DataController().addNewProduct(productData);
      print('Data for login $productData');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    // return Form(
    //   key: _formKey,
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Image.network('https://picsum.photos/205?image=9'),
    //       Container(
    //         width: 280,
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             // Validate returns true if the form is valid, or false otherwise.
    //             if (_formKey.currentState!.validate()) {
    //               // If the form is valid, display a snackbar. In the real world,
    //               // you'd often call a server or save the information in a database.
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Processing Data')),
    //               );
    //             }
    //           },
    //           child: const Text('Pick an Image'),
    //         ),
    //       ),
    //       const SizedBox(
    //         height: 100,
    //       ),
    //       TextFormField(
    //         // The validator receives the text that the user has entered.
    //         validator: (value) {
    //           if (value == null || value.isEmpty) {
    //             return 'Please enter some text';
    //           }
    //           return null;
    //         },
    //       ),
    //       TextFormField(
    //         decoration: const InputDecoration(labelText: 'Product Name'),
    //         // The validator receives the text that the user has entered.
    //         validator: (value) {
    //           if (value == null || value.isEmpty) {
    //             return 'Please enter some text';
    //           }
    //           return null;
    //         },
    //       ),
    //       const TextField(
    //         decoration: InputDecoration(labelText: 'Description'),
    //         keyboardType: TextInputType.multiline,
    //         minLines: 4, // <-- SEE HERE
    //         maxLines: 10, // <-- SEE HERE
    //       ),
    //       TextFormField(
    //         decoration: const InputDecoration(labelText: 'Price'),
    //         // The validator receives the text that the user has entered.
    //         validator: (value) {
    //           if (value == null || value.isEmpty) {
    //             return 'Please enter some text';
    //           }
    //           return null;
    //         },
    //       ),
    //       Padding(
    //         padding: const EdgeInsets.symmetric(vertical: 16.0),
    //         child: ElevatedButton(
    //           onPressed: () {
    //             // Validate returns true if the form is valid, or false otherwise.
    //             if (_formKey.currentState!.validate()) {
    //               // If the form is valid, display a snackbar. In the real world,
    //               // you'd often call a server or save the information in a database.
    //               ScaffoldMessenger.of(context).showSnackBar(
    //                 const SnackBar(content: Text('Processing Data')),
    //               );
    //             }
    //           },
    //           child: const Text('Submit'),
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add New Product'),
      ),
      body: Card(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Name Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_name'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Product Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Product Price Required';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    productData['p_price'] = value!;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number  Required';
                    }
                    return null;
                  },
                  // onSaved: (value) {
                  //   productData['phone_number'] = value!;
                  // },
                ),
                const SizedBox(
                  height: 10,
                ),
                ProductImagePicker(),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: addProduct,
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
