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

  
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0), 
        child: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.qr_code, color: Colors.white),
            onPressed: () {
              _logger.info('QR Code Pressionado');
            },
          ),
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
                  ),
                ),
                // Botão redondo com ícone de "cone sanduíche"
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.menu, color: Colors.white),  
                      onPressed: () {
                        _logger.info('Menu Pressionado');
                      },
                      iconSize: 30.0, 
                      splashRadius: 25.0, 
                    ),
                  ),
                ),
              ],
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
