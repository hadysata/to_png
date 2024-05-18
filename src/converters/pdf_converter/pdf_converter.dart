import 'dart:ffi';
import 'dart:io';
import 'dart:isolate';

import 'package:ffi/ffi.dart';
import 'package:image/image.dart';
import 'package:path/path.dart' as path;
import 'package:pdfium_bindings/pdfium_bindings.dart';

class PdfConverter {
  static void convert({required String inputFilePath, required String outputFilePath, required int scale}) async {
    final dylib = DynamicLibrary.open(await libraryPath);
    final pdfium = PDFiumBindings(dylib);

    const allocate = calloc;

    final config = allocate<FPDF_LIBRARY_CONFIG>();
    config.ref.version = 2;
    config.ref.m_pUserFontPaths = nullptr;
    config.ref.m_pIsolate = nullptr;
    config.ref.m_v8EmbedderSlot = 0;
    pdfium.FPDF_InitLibraryWithConfig(config);

    final filePathP = stringToNativeInt8(inputFilePath);

    final doc = pdfium.FPDF_LoadDocument(filePathP, nullptr);
    if (doc == nullptr) {
      final err = pdfium.FPDF_GetLastError();
      throw PdfiumException.fromErrorCode(err);
    }

    final page = pdfium.FPDF_LoadPage(doc, 0);
    if (page == nullptr) {
      final err = pdfium.getLastErrorMessage();
      pdfium.FPDF_CloseDocument(doc);
      throw PageException(message: err);
    }

    final width = (pdfium.FPDF_GetPageWidth(page) * scale).round();
    final height = (pdfium.FPDF_GetPageHeight(page) * scale).round();

    const background = 0;
    const startX = 0;
    final sizeX = width;
    const startY = 0;
    final sizeY = height;
    const rotate = 0;

    final bitmap = pdfium.FPDFBitmap_Create(width, height, 1);
    pdfium.FPDFBitmap_FillRect(bitmap, 0, 0, width, height, background);
    pdfium.FPDF_RenderPageBitmap(bitmap, page, startX, startY, sizeX, sizeY, rotate, FPDF_ANNOT | FPDF_LCD_TEXT);
    //  The pointer to the first byte of the bitmap buffer The data is in BGRA format
    final pointer = pdfium.FPDFBitmap_GetBuffer(bitmap);

    final Image image = Image.fromBytes(
      width: width,
      height: height,
      bytes: pointer.asTypedList(width * height * 4).buffer,
      order: ChannelOrder.bgra,
      numChannels: 4,
    );

    // save bitmap as PNG.
    File(outputFilePath).writeAsBytesSync(encodePng(image));

    //clean
    pdfium.FPDFBitmap_Destroy(bitmap);

    pdfium.FPDF_ClosePage(page);
    allocate.free(filePathP);

    pdfium.FPDF_DestroyLibrary();
    allocate.free(config);
  }

static Future<String> get libraryPath async {
    // Resolve the URI to the package's lib directory
    var packageUri = await Isolate.resolvePackageUri(
      Uri.parse('package:to_png/pdfium/'));
    
    if (packageUri == null) {
      throw Exception('Failed to resolve package directory');
    }

    final basePath = packageUri.toFilePath();

    if (Platform.isWindows) {
      return path.join(basePath, 'pdfium.dll');
    } else if (Platform.isLinux) {
      return path.join(basePath, 'libpdfium.so');
    } else if (Platform.isMacOS) {
      return path.join(basePath, 'libpdfium.dylib');
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
