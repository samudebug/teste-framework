import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:pdf_repository/pdf_repository.dart';

class PDFRepository implements IPDFRepository {
  @override
  Future<File> createPDF(pw.Widget content) async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return content;
        }));
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/recibo.pdf");
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}
