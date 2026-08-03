import 'package:flutter/material.dart';

IconData getAttachmentIcon(String extension) {
  switch (extension.toLowerCase()) {
    case 'pdf':
      return Icons.picture_as_pdf_rounded;

    case 'jpg':
    case 'jpeg':
    case 'png':
      return Icons.image_rounded;

    case 'doc':
    case 'docx':
      return Icons.description_rounded;

    default:
      return Icons.insert_drive_file_rounded;
  }
}
