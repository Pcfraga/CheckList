import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:checklist/data/http/http_client.dart';
import 'package:checklist/data/models/getAllCheckList_model.dart';
import 'package:checklist/data/repository/getAllCheckList_repository.dart';

void main() {
  // Inicializa o aplicativo e configura o logging
  runApp(const MyApp());
  _setupLogging();
}

final Logger _logger = Logger('GetAllCheckListModelsDTO');

// Função para configurar o logging
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
    // O widget raiz do aplicativo, onde a tela principal é definida
    return MaterialApp(
      title: 'My App',
      home: const GetAllCheckListModelsView(),
    );
  }
}

class GetAllCheckListModelsView extends StatefulWidget {
  const GetAllCheckListModelsView({super.key});

  @override
  GetAllCheckListModelsDTOState createState() =>
      GetAllCheckListModelsDTOState();
}

class GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsView> {
  // Variáveis de estado
  bool isAuthenticated = true;
  String greeting = "Olá, Usuário";
  String profileImageUrl =
      'https://drive.google.com/uc?export=view&id=1y3hAimY4iczJs2qlBGbnsS4BLI1PcvFQ';

  List<GetAllCheckListModelsDTO> checkLists = [];
  final TextEditingController _searchController = TextEditingController();
  final HttpClient httpClient = HttpClient();
  late final GetAllCheckListRepository checkListRepository;

  @override
  void initState() {
    super.initState();
    // Inicializa o repositório e carrega a lista de checklists
    checkListRepository = GetAllCheckListRepository(httpClient);
    _loadcheckList();
  }

  // Função que carrega os checklists
  Future<void> _loadcheckList() async {
    try {
      List<GetAllCheckListModelsDTO> fetchedcheckLists =
          await checkListRepository.getAllCheckList();
      setState(() {
        checkLists = fetchedcheckLists;
      });
    } catch (e) {
      print('Erro ao carregar checkLists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.black,
  appBar: PreferredSize(
    preferredSize: Size.fromHeight(100.0),
    child: SafeArea(  // SafeArea garante que não sobreponha a status bar
      child: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              Icons.document_scanner,
              color: Color(0xFFF25C05), // Muda a cor do ícone para #F25C05
            ),
            onPressed: () {
              _logger.info('Document Scanner Pressionado');
            },
          ),
        ],
        title: Padding(
          padding: const EdgeInsets.only(top: 16.0),  // Ajuste o afastamento aqui
          child: Row(
            children: [
              CircleAvatar(
                radius: 27.5,
                backgroundImage: NetworkImage(profileImageUrl),
              ),
              const SizedBox(width: 14),
              Text(
                greeting,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ),
  ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Lista de Verificação",
                style: const TextStyle(
                  color: Color.fromARGB(150, 235, 240, 240),
                  fontFamily: 'DM Sans',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 23.44 / 18,
                  letterSpacing: 0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 18), // Espaço entre o título e o campo de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Campo de pesquisa alinhado à esquerda
                Expanded(
                  child: Container(
                    height: 49,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    decoration: BoxDecoration(
                      color: Colors.grey[800], // Cor do campo de pesquisa
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar',
                        hintStyle: const TextStyle(color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 18), // Espaço entre o campo de pesquisa e o ícone
                // Ícone de filtro alinhado à direita
                Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    color: Color(0xFFF25C05), // Cor do filtro
                    shape: BoxShape.circle, // Forma circular do filtro
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.filter_list,
                        color: Colors.white,
                        size: 28, // Tamanho do ícone
                      ),
                      onPressed: () {
                        _logger.info('Filtro Pressionado');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 26), // Espaço entre o campo de pesquisa e os itens da lista
          Expanded(
            child: ListView.builder(
              itemCount: checkLists.length, // Quantidade de itens na lista
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[800], // Cor de fundo dos itens da lista
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        checkLists[index].title,
                        style: const TextStyle(
                          color: Colors.white, // Cor do título
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        checkLists[index].areaName,
                        style: const TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Revisão: ${checkLists[index].revisionNumber}',
                        style: const TextStyle(color: Colors.white60, fontSize: 14),
                      ),
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
