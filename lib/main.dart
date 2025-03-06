import 'package:checklist/screens/getAllCheckListViewDTO.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logging/logging.dart'; // Adicione o import da sua nova tela LvsScreen

void main() {
  runApp(const MyApp());
}

final Logger _logger = Logger('GetAllCheckListModelsDTO');

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    _logger.info('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckList',
      theme: ThemeData(
        // Aplicando a fonte DM Sans globalmente
        textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
      home: const GetAllCheckListModelsView(),
    );
  }
}
