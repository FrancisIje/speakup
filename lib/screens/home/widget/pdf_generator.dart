import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:speakup/screens/home/widget/chat_message.dart';

class PdfGenerator {
  Future<void> generateChatPdf(List<ChatMessage> messages) async {
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (context) {
        var content = <pw.Widget>[];
        for (var message in messages.reversed) {
          content.add(
            pw.Column(
              children: [
                pw.SizedBox(height: 15),
                pw.Text(
                  message.role,
                  style: pw.TextStyle(font: font, fontSize: 16),
                ),
                pw.SizedBox(height: 5),
                pw.Text(
                  message.text,
                  style: pw.TextStyle(font: font, fontSize: 14),
                ),
              ],
            ),
          );
        }
        return pw.Column(children: content);
      },
    ));

    Uint8List pdfBytes = await pdf.save();

    savePdf(pdfBytes);
  }

  Future<void> savePdf(Uint8List pdfBytes) async {
    if (await Permission.storage.request().isGranted) {
      await getApplicationDocumentsDirectory();
      // You can also use getApplicationDocumentsDirectory() for app-specific directory.

      final file = File(
          '/storage/emulated/0/Download/chat_history_${pdfBytes.length}.pdf');

      await file.writeAsBytes(pdfBytes);

      // Provide feedback to the user or perform any additional actions.
      print('PDF saved to: ${file.path}');

      // Handle the case where the external storage directory is not available.
      print('External storage directory not available.');
    } else {
      // Handle the case where storage permission is not granted.
      print('Storage permission not granted.');
    }
  }
}
