import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


enum PDFSourceType {
  network,
  local,
  asset,
}

class PDFViewerWidget extends StatelessWidget {
  final String pdfUrl;
   final bool isAsset; // Optionnel maintenant

  const PDFViewerWidget({
    super.key,
    required this.pdfUrl,
    this.isAsset = false, // Rendu optionnel
  });

  @override
  Widget build(BuildContext context) {
    return isAsset
        ? SfPdfViewer.asset(pdfUrl)
        : SfPdfViewer.network('https://www.tresfacile.net/doc/python/python-tres-facile-preview.pdf');
  }

}


