import 'package:flutter/material.dart'; // Pacote para criar interfaces no Flutter
import 'package:logging/logging.dart'; // Pacote para registrar logs de eventos e erros
import 'package:myapp/data/http/http_client.dart'; // Importa o HttpClient para fazer requisições HTTP
import 'package:myapp/data/models/getAllCheckList_model.dart'; // Modelo que representa os dados da checklist
import 'package:myapp/data/repository/getAllCheckList_repository.dart'; // Repositório que gerencia os dados de checklist

// Função principal que inicia o app
void main() {
  runApp(MyApp()); // Inicializa o aplicativo com o widget MyApp
  _setupLogging(); // Configura a função de logging
}

// Logger para rastrear as mensagens do sistema
final Logger _logger = Logger('GetAllCheckListModelsDTO');

// Configuração do sistema de logs
void _setupLogging() {
  Logger.root.level =
      Level.ALL; // Define o nível de log para registrar todas as mensagens
  Logger.root.onRecord.listen((record) {
    // Formatação das mensagens de log (nível, data/hora e mensagem)
    _logger.info('${record.level.name}: ${record.time}: ${record.message}');
  });
}

// Widget principal do aplicativo que não tem estado (StatelessWidget)
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Construtor da classe

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // O MaterialApp define o tema e estrutura do app
      title: 'My App', // Título do aplicativo
      home:
          GetAllCheckListModelsView(), // Tela inicial que será exibida ao usuário
    );
  }
}

// Widget com estado que exibe a tela com os dados da checklist
class GetAllCheckListModelsView extends StatefulWidget {
  const GetAllCheckListModelsView({super.key}); // Construtor da classe

  @override
  GetAllCheckListModelsDTOState createState() =>
      GetAllCheckListModelsDTOState(); // Cria o estado para esse widget
}

// O estado associado ao widget GetAllCheckListModelsView
class GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsView> {
  bool isAuthenticated =
      true; // Variável que controla se o usuário está autenticado
  String greeting = "Olá, Usuário"; // Saudação que será exibida na tela
  String profileImageUrl =
      'https://drive.google.com/uc?export=view&id=1y3hAimY4iczJs2qlBGbnsS4BLI1PcvFQ'; // URL da imagem de perfil do usuário

  // Lista que será preenchida com os dados da checklist da API
  List<GetAllCheckListModelsDTO> checkLists = [];

  // Controlador para o campo de busca (não utilizado para lógica, mas para controlar o texto)
  final TextEditingController _searchController = TextEditingController();

  // Instancia o HttpClient para fazer as requisições à API
  final HttpClient httpClient = HttpClient(); // Cliente HTTP

  // Usando o "late" para garantir que o repositório será inicializado posteriormente
  late final GetAllCheckListRepository
  checkListRepository; // Repositório que irá buscar os dados

  @override
  void initState() {
    super.initState();
    // Inicializa o repositório passando o HttpClient para ele
    checkListRepository = GetAllCheckListRepository(httpClient);
    _loadcheckList(); // Carrega os dados da checklist ao iniciar
  }

  // Função assíncrona para carregar os dados da API
  Future<void> _loadcheckList() async {
    try {
      // Tenta buscar os dados da API usando o repositório
      List<GetAllCheckListModelsDTO> fetchedcheckLists =
          await checkListRepository.getAllCheckList();
      setState(() {
        // Atualiza a lista 'checkLists' com os dados obtidos da API
        checkLists = fetchedcheckLists;
      });
    } catch (e) {
      // Em caso de erro, exibe uma mensagem no console
      print('Erro ao carregar checkLists: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold cria a estrutura básica da tela, como AppBar, corpo, etc.
      backgroundColor: Colors.black, // Cor de fundo da tela
      appBar: PreferredSize(
        // Barra superior personalizada
        preferredSize: Size.fromHeight(60.0), // Define a altura da AppBar
        child: AppBar(
          backgroundColor: Colors.black, // Cor de fundo da AppBar
          actions: [
            // QR Code à direita
            IconButton(
              icon: Icon(
                Icons.qr_code,
                color: Colors.white,
              ), // Ícone de QR Code
              onPressed: () {
                _logger.info(
                  'QR Code Pressionado',
                ); // Loga quando o QR Code é pressionado
              },
            ),
          ],
          title: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                // CircleAvatar à esquerda
                CircleAvatar(
                  radius: 30, // Tamanho do círculo
                  backgroundImage: NetworkImage(
                    profileImageUrl,
                  ), // Carrega a imagem do perfil pela URL
                ),
                SizedBox(width: 16), // Espaço entre o CircleAvatar e a saudação
                // Saudação ao lado do avatar
                Text(
                  greeting, // Exibe a saudação
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Spacer(), // Para empurrar o QR Code para a direita
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              "Itens da Lista", // Título para a lista de itens
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                // Campo de pesquisa à esquerda
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Pesquisar...",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        filled: true,
                        fillColor: Colors.grey[800],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Ícone de Menu à direita
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    _logger.info('Menu Pressionado');
                  },
                  iconSize: 30.0,
                  splashRadius: 25.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:
                  checkLists.length, // Número de itens na lista de checkLists
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[700],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          checkLists[index].title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        checkLists[index].areaName,
                        style: TextStyle(color: Colors.white60, fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Área ID: ${checkLists[index].areaId}',
                        style: TextStyle(color: Colors.white60, fontSize: 14),
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
