import 'package:flutter/material.dart';
import 'package:logging/logging.dart';  // Importando o pacote de logging

void main() {
  runApp(MyApp());
  _setupLogging(); // Configurar logging
}

// Configuração do Logger
void _setupLogging() {
  Logger.root.level = Level.ALL; // Nível do logger (ALL vai registrar tudo)
  Logger.root.onRecord.listen((record) {
    // Registra a mensagem de log com o nível, data/hora e o texto
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: GetAllCheckListModelsDTO(),
    );
  }
}

class GetAllCheckListModelsDTO extends StatefulWidget {
  const GetAllCheckListModelsDTO({super.key});

  @override
  _GetAllCheckListModelsDTOState createState() =>
      _GetAllCheckListModelsDTOState();
}

class _GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsDTO> {
  // Instanciando o Logger
  final Logger _logger = Logger('GetAllCheckListModelsDTO');

  bool isAuthenticated = true;
  String greeting = "Olá, usuário";
  String profileImageUrl = 'https://www.example.com/your-profile-image.jpg';
  List<String> listItems = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {
              // Usando o Logger para registrar o evento
              _logger.info('QR Code Pressionado');
            },
          ),
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: [
                  isAuthenticated
                      ? Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(profileImageUrl),
                            ),
                            SizedBox(width: 10),
                            Text(
                              greeting,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "Faça login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listItems.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  listItems[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
