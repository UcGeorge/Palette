import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../views/widgets/color_box.dart';
import '../classes/palette.dart';

class ExportService {
  static copyUrl(
    BuildContext context, {
    required Palette palette,
    VoidCallback? onSuccess,
  }) async {
    final url =
        "https://coolors.co/palette/${palette.map((e) => e.colorTextHEX).join('-')}";
    await Clipboard.setData(ClipboardData(text: url));
    onSuccess?.call();
  }

  static pdf(
    BuildContext context, {
    required Palette palette,
    VoidCallback? onSuccess,
  }) async {
    final screenshotController = ScreenshotController();
    final pdf = pw.Document();

    final export = Container(
      height: 1080,
      width: 1440,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            child: Row(
              children: [
                ColorBox(palette[0]),
                ColorBox(palette[1]),
                ColorBox(palette[2]),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                ColorBox(palette[3]),
                ColorBox(palette[4]),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset('assets/svg/logo.svg'),
            ),
          ),
          const Spacer(),
        ],
      ),
    );

    screenshotController
        .captureFromWidget(
      export,
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
      delay: const Duration(milliseconds: 10),
    )
        .then(
      (Uint8List image) async {
        final directory = await getApplicationDocumentsDirectory();

        final pwImage = pw.MemoryImage(image);

        pdf.addPage(pw.Page(
          build: (pw.Context context) {
            return pw.Center(child: pw.Image(pwImage)); // Center
          },
        ));

        final pdfPath = await File(
                '${directory.path}/${palette.map((e) => e.colorTextHEX.toUpperCase()).join('-')}.pdf')
            .create();
        await pdfPath.writeAsBytes(await pdf.save());

        /// Share Plugin
        await Share.shareFiles(
          [pdfPath.path],
          text:
              '${palette.map((e) => "#${e.colorTextHEX.toUpperCase()} - ${e.colorTextRGB}").join('\n')}\n\nI generated this palette with the Palette app, coming soon to the Play Store & App Store.🚀',
        );
      },
    );

    onSuccess?.call();
  }

  static image(
    BuildContext context, {
    required Palette palette,
    VoidCallback? onSuccess,
  }) async {
    final screenshotController = ScreenshotController();

    final export = Container(
      height: 1080,
      width: 1440,
      padding: const EdgeInsets.all(8),
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            child: Row(
              children: [
                ColorBox(palette[0]),
                ColorBox(palette[1]),
                ColorBox(palette[2]),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Row(
              children: [
                ColorBox(palette[3]),
                ColorBox(palette[4]),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset('assets/svg/logo.svg'),
            ),
          ),
          const Spacer(),
        ],
      ),
    );

    screenshotController
        .captureFromWidget(
      export,
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
      delay: const Duration(milliseconds: 10),
    )
        .then(
      (Uint8List image) async {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File(
                '${directory.path}/${palette.map((e) => e.colorTextHEX.toUpperCase()).join('-')}.png')
            .create();
        await imagePath.writeAsBytes(image);

        final url =
            "https://coolors.co/palette/${palette.map((e) => e.colorTextHEX).join('-')}";

        /// Share Plugin
        await Share.shareFiles(
          [imagePath.path],
          text:
              '${palette.map((e) => "#${e.colorTextHEX.toUpperCase()} - ${e.colorTextRGB}").join('\n')}\n\n$url\n\nI generated this palette with the Palette app, coming soon to the Play Store & App Store.🚀',
        );
      },
    );

    onSuccess?.call();
  }

  static svg(
    BuildContext context, {
    required Palette palette,
    VoidCallback? onSuccess,
  }) async {
    //TODO: Perform SVG export
    onSuccess?.call();
  }

  static ase(
    BuildContext context, {
    required Palette palette,
    VoidCallback? onSuccess,
  }) async {
    //TODO: Perform ASE export
    onSuccess?.call();
  }
}
