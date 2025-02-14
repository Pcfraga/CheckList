import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:myapp/data/http/http_client.dart';
import 'package:myapp/data/models/getAllCheckList_model.dart';
import 'package:myapp/data/repository/getAllCheckList_repository.dart';  

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
      home: GetAllCheckListModelsView(),
    );
  }
}

class GetAllCheckListModelsView extends StatefulWidget {
  const GetAllCheckListModelsView({super.key});

  @override
  GetAllCheckListModelsDTOState createState() => GetAllCheckListModelsDTOState();
}

class GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsView> {
  bool isAuthenticated = true;
  String greeting = "Olá, usuário";
  String profileImageUrl = 'https://www.example.com/your-profile-image.jpg';

  // Lista de itens que será preenchida com dados da API
  List<GetAllCheckListModelsDTO> checkLists = [];

  // Controlador para o campo de busca
  final TextEditingController _searchController = TextEditingController();

  // Instanciando o HttpClient (IHttpClient)
  final HttpClient httpClient = HttpClient(); // Criando a instância do HttpClient

  late final GetAllCheckListRepository checkListRepository; // Usando `late` para inicializar no construtor

  @override
  void initState() {
    super.initState();
    // Inicializando o AreaRepository dentro do initState
    checkListRepository = GetAllCheckListRepository(httpClient); // Passando o httpClient para o repositório
    _loadcheckList(); // Carregar as áreas na inicialização
  }

  // Função para carregar as áreas da API
  Future<void> _loadcheckList() async {
    try {
      List<GetAllCheckListModelsDTO> fetchedcheckLists = await checkListRepository.getAllCheckList();
      setState(() {
        checkLists = fetchedcheckLists; // Atualiza a lista de áreas
      });
    } catch (e) {
      // Em caso de erro, logar ou mostrar uma mensagem para o usuário
      print('Erro ao carregar checkLists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150.0),
        child: AppBar(
          backgroundColor: Colors.black,
          actions: [
            IconButton(
              icon: Icon(Icons.qr_code, color: Colors.white),
              onPressed: () {
                _logger.info('QR Code Pressionado');
              },
            ),
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
                      // Realizar a busca com o valor digitado
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body:
      
       Column(
        children: [
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
          
          Expanded(
            child: ListView.builder(
              itemCount: checkLists.length, // Usar o tamanho da lista 'areas' que foi preenchida
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
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          checkLists[index].title, // Exibir o nome da área
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
