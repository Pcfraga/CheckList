import 'package:flutter/material.dart';
import 'package:logging/logging.dart';  

void main() {
  runApp(MyApp());
  _setupLogging(); 
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
      title: 'My App',
      home: GetAllCheckListModelsDTO(),
    );
  }
}

class GetAllCheckListModelsDTO extends StatefulWidget {
  const GetAllCheckListModelsDTO({super.key});

  @override
  GetAllCheckListModelsDTOState createState() => GetAllCheckListModelsDTOState();
}

class GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsDTO> {
  bool isAuthenticated = true;
  String greeting = "Olá, usuário";
  String profileImageUrl = 'https://www.example.com/your-profile-image.jpg';
  
  // Lista de itens
  List<String> listItems = [
    "QSMS",
    "MEIO AMBIENTE",
    "SEGURANÇA",
    "QUALIDADE",
    "SAÚDE",
    "COMUNICAÇÃO",
    "ADMINISTRAÇÃO",
    "GERÊNCIA",
  ];

  // Controlador para o campo de busca (para GET)
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), 
        child: AppBar(
          backgroundColor: Colors.black,
          actions: [
            // Mover o QR Code para a direita, no 'actions'
            IconButton(
              icon: Icon(Icons.qr_code, color: Colors.white),
              onPressed: () {
                _logger.info('QR Code Pressionado');
              },
            ),
            // Botão redondo com ícone de "cone sanduíche"
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),  
              onPressed: () {
                _logger.info('Menu Pressionado');
              },
              iconSize: 30.0, 
              splashRadius: 25.0, 
            ),
          ],
          flexibleSpace: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Pesquisar...",
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIcon: Icon(Icons.search, color: Colors.white),  
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0), 
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) {
                      // Realizar a ação de GET aqui com o valor digitado
                      // Por exemplo: chamar a API com o valor de 'value'
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Título centralizado acima da lista
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Itens da Lista",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          
          // Lista de itens (não editáveis)
          Expanded(
            child: ListView.builder(
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Box com título de cada item com cantos arredondados
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[700], // Cor de fundo do box
                          borderRadius: BorderRadius.circular(12), // Cantos arredondados
                        ),
                        child: Text(
                          listItems[index],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
