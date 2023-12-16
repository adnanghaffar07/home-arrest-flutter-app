import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:home_arrest/providers/user_provider.dart';
import 'package:home_arrest/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:home_arrest/mixins/appbar_mixin.dart';

class AddSignatureScreen extends StatefulWidget {
  static const routeName = '/add_signature_screen';
  const AddSignatureScreen({super.key});

  @override
  State<AddSignatureScreen> createState() => _AddSignatureScreenState();
}

class _AddSignatureScreenState extends State<AddSignatureScreen> with AppbarMixin {
  late SignatureController signatureController;

  @override
  void initState() {
    super.initState();
    signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: const Color(0xFF21356A),
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    signatureController.dispose();
    super.dispose();
  }

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: signatureController.points,
    );
    final signature = await exportController.toPngBytes();
    exportController.dispose();
    return signature;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF21356A),
      appBar: baseStyleAppBar(
        title: 'Add Signature',
        backgroundColor: Colors.transparent,
        actions: [
          InkWell(
            onTap: () async {
              if (signatureController.isNotEmpty) {
                exportSignature().then((signature) {
                  inspect(XFile.fromData(signature ?? Uint8List(0)));
                  // Provider.of<UserProvider>(context, listen: false).updateUserSignature(XFile.fromData(signature!), context);
                });
              } else {
                Utils.showErrorToast(context, 'Please add signature');
              }
            },
            child: Container(
              height: 35,
              width: 35,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Provider.of<UserProvider>(context, listen: false).isLoading
                  ? const Center(child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator(color: Color(0xFF21356A), strokeWidth: 2)))
                  : const Icon(Icons.check, color: Color(0xFF21356A), size: 20),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Signature(
                height: MediaQuery.of(context).size.height * 0.4,
                controller: signatureController,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
