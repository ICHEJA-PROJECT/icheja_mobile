import 'package:flutter/material.dart';
import 'package:icheja_mobile/auth/presentation/viewmodels/qr_scanner_viewmodel.dart';
import 'package:icheja_mobile/auth/presentation/widgets/qr_scanner_view.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:provider/provider.dart';

class QRScannerPage extends StatelessWidget {
  const QRScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => sl<QRScannerViewModel>(),
      child: const QRScannerView(),
    );
  }
}
