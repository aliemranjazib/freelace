import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:printing/printing.dart';
import '../model/Agreement.dart';
import 'printable_data.dart';
import 'package:http/http.dart' as http;
// import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SaveBtnBuilder extends StatelessWidget {
  SaveBtnBuilder(this.agreement);
  late final Agreement agreement;

  @override
  Widget build(BuildContext context) {
    AssetImage(agreement.img) as ImageProvider;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        onPrimary: Colors.indigo,
        primary: Colors.indigo,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: () => printDoc(),
      child: const Text(
        "Save as PDF",
        style: TextStyle(color: Colors.white, fontSize: 20.00),
      ),
    );
  }

  Future<void> printDoc() async {
    final image =
        await imageFromAssetBundle("assets/images/eagree.png", cache: true);
    final image1 = await networkImage(
      agreement.signature,
      cache: true,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
    final image2 = await networkImage(
      agreement.client_signature,
      cache: true,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Access-Control-Allow-Credentials":
            'true', // Required for cookies, authorization headers with HTTPS
        "Access-Control-Allow-Headers":
            "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
    );
    // final image = await networkImage(agreement.img);
    // final image = ImageProvider(agreement.img);

    final doc = pw.Document();

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(image, image1, image2);
        }));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  buildPrintableData(image, imag1, image2) => pw.Padding(
        padding: const pw.EdgeInsets.all(25.00),
        child: pw.Column(children: [
          pw.Text(" Agreement",
              style: pw.TextStyle(
                  fontSize: 25.00, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 10.00),
          pw.Divider(),
          pw.Align(
              alignment: pw.Alignment.topRight,
              child: pw.Row(children: [
                pw.Image(
                  image,
                  width: 100,
                  height: 100,
                ),
                pw.Image(
                  imag1,
                  width: 100,
                  height: 100,
                ),
                pw.Image(
                  image2,
                  width: 100,
                  height: 100,
                ),
              ])),
          pw.Column(
            children: [
              pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  // pw.SizedBox(width: 5.5),
                  // pw.Text(
                  //   "Invoice",
                  //   style: pw.TextStyle(
                  //       fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  // )
                ],
              ),
              pw.SizedBox(height: 10.00),
              pw.Container(
                // color: const PdfColor(0.5, 1, 0.5, 0.7),
                width: double.infinity,
                height: 36.00,
                child: pw.Center(
                  child: pw.Text(
                    "Product Details",
                    style: pw.TextStyle(
                        color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                        fontSize: 20.00,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              // for (var i = 0; i < 3; i++)
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Product Name : ${agreement.name}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Product Price : ${agreement.price}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Product Description : ${agreement.description}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Product Location : ${agreement.location}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Product Price : ${agreement.price}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                child: pw.Container(
                  child: pw.Text(
                    "Buyer Details",
                    style: pw.TextStyle(
                        color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                        fontSize: 20.00,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Buyer Name : ${agreement.client_name}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Buyer Location : ${agreement.client_location}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Purchase Date  : ${agreement.client_date}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                child: pw.Container(
                  child: pw.Text(
                    "Buyer Payment Details",
                    style: pw.TextStyle(
                        color: const PdfColor(0.2, 0.6, 0.2, 0.7),
                        fontSize: 20.00,
                        fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Account Number  : ${agreement.account_no}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Institution Number  : ${agreement.institution_no}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              pw.Container(
                width: double.infinity,
                height: 30.00,
                child: pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 25.0),
                  child: pw.Text(
                    "Transit Number  : ${agreement.transit_no}",
                    style: pw.TextStyle(
                        fontSize: 16.00, fontWeight: pw.FontWeight.bold),
                  ),
                ),
              ),
              // pw.SizedBox(height: 15.00),
              // pw.Text(
              //   "Thanks for choosing our service!",
              //   style: const pw.TextStyle(
              //       color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
              // ),
              // pw.SizedBox(height: 5.00),
              // pw.Text(
              //   "Contact the branch for any clarifications.",
              //   style: const pw.TextStyle(
              //       color: PdfColor(0.5, 0.5, 0.5, 0.5), fontSize: 15.00),
              // ),
              // pw.SizedBox(height: 15.00),
            ],
          )
        ]),
      );
}
