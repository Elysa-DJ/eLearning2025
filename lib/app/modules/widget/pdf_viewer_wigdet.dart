import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:path/path.dart' as path;
import 'dart:developer' as developer;

enum PDFSourceType {
  network,
  local,
  asset,
}

class PDFViewerWidget extends StatefulWidget {
  final String pdfUrl;
  final PDFSourceType? sourceType; // Optionnel maintenant

  const PDFViewerWidget({
    super.key,
    required this.pdfUrl,
    this.sourceType, // Rendu optionnel
  });

  // Méthode statique pour déterminer le type de source
  static PDFSourceType _determineSourceType(String path) {
    if (path.startsWith('http://') || path.startsWith('https://')) {
      return PDFSourceType.network;
    } else if (path.startsWith('assets/') || path.startsWith('asset:')) {
      return PDFSourceType.asset;
    } else {
      return PDFSourceType.local;
    }
  }

  @override
  State<PDFViewerWidget> createState() => _PDFViewerWidgetState();
}

class _PDFViewerWidgetState extends State<PDFViewerWidget> {
  final PdfViewerController _controller = PdfViewerController();
  bool _isLoading = true;
  String? _error;
  File? _localFile;
  bool _pdfReady = false;
  late PDFSourceType _sourceType;

  @override
  void initState() {
    super.initState();
    // Utilise le type de source fourni ou le détermine automatiquement
    _sourceType = widget.sourceType ?? PDFViewerWidget._determineSourceType(widget.pdfUrl);
    _loadPdf();
  }

  @override
  void dispose() {
    _cleanupTempFile();
    super.dispose();
  }

  void _cleanupTempFile() {
    if (_localFile != null && _sourceType == PDFSourceType.asset) {
      try {
        if (_localFile!.existsSync()) {
          _localFile!.deleteSync();
          developer.log('Fichier temporaire supprimé: ${_localFile!.path}');
        }
      } catch (e) {
        developer.log('Erreur lors de la suppression du fichier temporaire: $e', error: e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              children: [
                // Barre d'outils PDF
                _buildToolbar(),
                
                // Contenu PDF
                Expanded(
                  child: _error != null 
                      ? _buildErrorView() 
                      : _pdfReady 
                          ? _buildPdfViewer() 
                          : const Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
        ),
        if (_isLoading && _error == null)
          const Center(
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildToolbar() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.blue.shade50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.zoom_in),
            onPressed: _pdfReady ? () => _controller.zoomLevel++ : null,
            color: _pdfReady ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.zoom_out),
            onPressed: _pdfReady ? () => _controller.zoomLevel-- : null,
            color: _pdfReady ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_before),
            onPressed: _pdfReady && _controller.pageNumber > 1 
                ? () => _controller.previousPage() 
                : null,
            color: _pdfReady && _controller.pageNumber > 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: const Icon(Icons.navigate_next),
            onPressed: _pdfReady ? () => _controller.nextPage() : null,
            color: _pdfReady ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 48,
          ),
          const SizedBox(height: 16),
          Text(
            _error!,
            style: const TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            "Chemin: ${widget.pdfUrl}",
            style: const TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              _loadPdf();
            },
            child: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }

  Widget _buildPdfViewer() {
    switch (_sourceType) {
      case PDFSourceType.network:
        return SfPdfViewer.network(
          widget.pdfUrl,
          controller: _controller,
          canShowPasswordDialog: true,
          onDocumentLoadFailed: _handleLoadError,
        );
      case PDFSourceType.local:
        return SfPdfViewer.file(
          File(widget.pdfUrl),
          controller: _controller,
          canShowPasswordDialog: true,
          onDocumentLoadFailed: _handleLoadError,
        );
      case PDFSourceType.asset:
        if (_localFile == null) {
          return const Center(child: Text('Préparation du fichier en cours...'));
        }
        return SfPdfViewer.file(
          _localFile!,
          controller: _controller,
          canShowPasswordDialog: true,
          onDocumentLoadFailed: _handleLoadError,
        );
    }
  }

  void _handleLoadError(PdfDocumentLoadFailedDetails details) {
    developer.log('Échec du chargement du PDF: ${details.error}', error: details.error);
    setState(() {
      _error = 'Impossible de charger le PDF: ${details.error}';
      _isLoading = false;
      _pdfReady = false;
    });
  }

  Future<void> _loadPdf() async {
    setState(() {
      _isLoading = true;
      _error = null;
      _pdfReady = false;
    });

    try {
      switch (_sourceType) {
        case PDFSourceType.asset:
          await _loadAssetPdf();
          break;
        case PDFSourceType.local:
          await _verifyLocalFile();
          break;
        case PDFSourceType.network:
          await _verifyNetworkUrl();
          break;
      }
      
      // Si aucune erreur n'a été définie, le PDF est prêt à être affiché
      if (_error == null) {
        setState(() {
          _pdfReady = true;
          _isLoading = false;
        });
      }
    } catch (e) {
      developer.log('Erreur générale lors du chargement du PDF: $e', error: e);
      setState(() {
        _error = 'Erreur lors du chargement du fichier: $e';
        _isLoading = false;
        _pdfReady = false;
      });
    }
  }

  Future<void> _loadAssetPdf() async {
    try {
      final ByteData data = await rootBundle.load(widget.pdfUrl);
      final Directory tempDir = await getTemporaryDirectory();
      final String filePath = path.join(tempDir.path, 'temp_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf');
      final File file = File(filePath);
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
      developer.log('PDF d\'asset écrit dans le fichier temporaire: $filePath');
      
      setState(() {
        _localFile = file;
      });
    } catch (e) {
      developer.log('Erreur lors du chargement du PDF depuis les assets: $e', error: e);
      setState(() {
        _error = 'Erreur lors du chargement du PDF depuis les assets: $e';
        _isLoading = false;
        _pdfReady = false;
      });
    }
  }

  Future<void> _verifyLocalFile() async {
    try {
      final file = File(widget.pdfUrl);
      if (!file.existsSync()) {
        setState(() {
          _error = 'Le fichier local n\'existe pas: ${widget.pdfUrl}';
          _isLoading = false;
          _pdfReady = false;
        });
        return;
      }
      
      // Vérifier que le fichier est bien un PDF
      final bytes = await file.readAsBytes().timeout(
        const Duration(seconds: 5),
        onTimeout: () => throw TimeoutException('Lecture du fichier trop longue'),
      );
      
      // Vérifier la signature PDF (%PDF-) au début du fichier
      if (bytes.length < 5 || 
          String.fromCharCodes(bytes.sublist(0, 5)) != '%PDF-') {
        setState(() {
          _error = 'Le fichier ne semble pas être un PDF valide';
          _isLoading = false;
          _pdfReady = false;
        });
        return;
      }
    } catch (e) {
      developer.log('Erreur lors de la vérification du fichier local: $e', error: e);
      setState(() {
        _error = 'Erreur lors de la vérification du fichier local: $e';
        _isLoading = false;
        _pdfReady = false;
      });
    }
  }

  Future<void> _verifyNetworkUrl() async {
    try {
      // Vérifier si l'URL est accessible
      final response = await http.head(Uri.parse(widget.pdfUrl)).timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('La requête a expiré');
        },
      );
      
      if (response.statusCode != 200) {
        developer.log('URL inaccessible (code ${response.statusCode}): ${widget.pdfUrl}');
        setState(() {
          _error = 'Le serveur a retourné une erreur (code ${response.statusCode})';
          _isLoading = false;
          _pdfReady = false;
        });
        return;
      }
      
      // Vérifier si le contenu est bien un PDF
      final contentType = response.headers['content-type'];
      if (contentType != null && 
          !contentType.toLowerCase().contains('application/pdf') && 
          !contentType.toLowerCase().contains('binary/octet-stream')) {
        developer.log('Le contenu ne semble pas être un PDF: $contentType');
        setState(() {
          _error = 'Le contenu ne semble pas être un PDF (type: $contentType)';
          _isLoading = false;
          _pdfReady = false;
        });
        return;
      }
      
      developer.log('URL accessible: ${widget.pdfUrl}');
    } catch (e) {
      developer.log('Erreur lors de la vérification de l\'URL: $e', error: e);
      // On continue avec le chargement normal même si la vérification échoue
      // car certains serveurs peuvent bloquer les requêtes HEAD
    }
  }
}