import 'dart:io';

import 'package:pdf/widgets.dart' as pw;

abstract class IPDFRepository {
  Future<File> createPDF(pw.Widget content);
}
