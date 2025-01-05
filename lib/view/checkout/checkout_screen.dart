import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test/const.dart';
import 'dart:io';
import 'package:test/model/product_model.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckoutScreen extends StatelessWidget {
  final List<Product>? products;

  CheckoutScreen({required this.products});

  double getTotalAmount() {
    return products?.fold(0.0, (sum, product) => sum! + product.price) ?? 0.0;
  }

  Future<void> generateReceipt() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'Receipt',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
            pw.Divider(),
            pw.ListView.builder(
              itemCount: products?.length ?? 0,
              itemBuilder: (context, index) {
                final product = products![index];
                return pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(product.name),
                    pw.Text('₹${product.price.toStringAsFixed(2)}'),
                  ],
                );
              },
            ),
            pw.Divider(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text(
                  'Total Amount',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.Text(
                  '₹${getTotalAmount().toStringAsFixed(2)}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    try {
      // Request storage permission
      if (await Permission.storage.request().isGranted) {
        // Get the Downloads directory
        final directory = Directory('/storage/emulated/0/Download');
        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        // Define the file path
        final file = File('${directory.path}/receipt.pdf');
        await file.writeAsBytes(await pdf.save());

        Get.snackbar(
          'Receipt Generated',
          'Saved as receipt.pdf in ${directory.path}',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          'Permission Denied',
          'Storage permission is required to save the file in the Downloads folder.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to generate receipt: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: products?.length ?? 0,
                itemBuilder: (context, index) {
                  final product = products![index];
                  return ListTile(
                    leading: Image.asset(
                      product.imageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text('₹${product.price.toStringAsFixed(2)}'),
                  );
                },
              ),
            ),
            kheight10,
            kheight5,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total: ₹${getTotalAmount().toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            kheight10,
            kheight5,
            ElevatedButton(
              onPressed: () {
                Get.defaultDialog(
                  title: 'Payment Successful',
                  middleText: 'Thank you for your purchase!',
                  confirm: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      generateReceipt();
                    },
                    child: const Text('Generate Receipt'),
                  ),
                );
              },
              child: const Text('Proceed to Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
