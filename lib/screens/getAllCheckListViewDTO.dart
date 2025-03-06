import 'package:checklist/screens/checkListDetailsScreen.dart';
import 'package:checklist/utilizaveis/cores';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:checklist/data/http/http_client.dart';
import 'package:checklist/data/models/getAllCheckList_model.dart';
import 'package:checklist/data/repository/getAllCheckList_repository.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:remixicon/remixicon.dart';

void main() {
  runApp(const MyApp()); // Executa o aplicativo principal
  _setupLogging(); // Configura o sistema de logging
}

// Cria um logger para rastrear mensagens específicas
final Logger _logger = Logger('GetAllCheckListModelsDTO');

// Configura o sistema de logging
void _setupLogging() {
  Logger.root.level = Level.ALL; // Define o nível de logging como todos
  Logger.root.onRecord.listen((record) {
    _logger.info('${record.level.name}: ${record.time}: ${record.message}');
  });
}

// Classe principal do aplicativo
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckList',
      home: const GetAllCheckListModelsView(), // Página inicial do app
    );
  }
}

// Classe que representa a visualização de todos os checklists
class GetAllCheckListModelsView extends StatefulWidget {
  const GetAllCheckListModelsView({super.key});

  @override
  GetAllCheckListModelsDTOState createState() => GetAllCheckListModelsDTOState(); // Cria o estado associado
}

// Estado da classe GetAllCheckListModelsView
class GetAllCheckListModelsDTOState extends State<GetAllCheckListModelsView> {
  bool isAuthenticated = true; // Verificação de autenticação
  String greeting = "Olá, Usuário"; // Mensagem de saudação
  String profileImageUrl = 'https://drive.google.com/uc?export=view&id=1y3hAimY4iczJs2qlBGbnsS4BLI1PcvFQ'; // URL da imagem do perfil
  var checkLists = <GetAllCheckListModelsDTO>[]; // Lista de checklists
  final TextEditingController _searchController = TextEditingController(); // Controlador de pesquisa
  final HttpClient httpClient = HttpClient(); // Instância do cliente HTTP
  late final GetAllCheckListRepository checkListRepository; // Repositório para os checklists

  bool _isFilterVisible = false; // Controle de visibilidade do filtro
  List<String> sectors = []; // Lista de setores dinâmicos
  List<bool> selectedSectors = []; // Registros de seleção de setores

  @override
  void initState() {
    super.initState();
    checkListRepository = GetAllCheckListRepository(httpClient); // Inicializa o repositório
    _loadcheckList(); // Carrega os checklists ao iniciar
  }

  Future<void> _loadcheckList() async {
    try {
      List<GetAllCheckListModelsDTO> fetchedCheckLists = await checkListRepository.getAllCheckList();
      setState(() {
        checkLists = fetchedCheckLists; // Atualiza a lista de checklists
        sectors = checkLists.map((checkList) => checkList.title).toSet().toList();
        selectedSectors = List.generate(sectors.length, (index) => false); // Inicializa a seleção
      });
    } catch (e) {
      print('Erro ao carregar checkLists: $e'); // Exibe erro no console, se ocorrer
    }
  }

  void _toggleFilterVisibility() {
    setState(() {
      _isFilterVisible = !_isFilterVisible; // Troca o estado de visibilidade
    });
  }

  void _applyFilters() {
    if (selectedSectors.contains(true)) {
      List<GetAllCheckListModelsDTO> filteredCheckLists = checkLists.where((checkList) {
        int index = sectors.indexOf(checkList.title);
        return index != -1 && selectedSectors[index]; // Verifica se o setor está selecionado
      }).toList();

      setState(() {
        checkLists = filteredCheckLists; // Atualiza a lista filtrada
      });
    } else {
      _loadcheckList(); // Se nenhum filtro estiver selecionado, recarrega a lista completa
    }

    _toggleFilterVisibility(); // Fecha a visualização do filtro
  }

  void _clearFilters() {
    setState(() {
      selectedSectors = List.generate(sectors.length, (index) => false); // Reseta todas as seleções
      _loadcheckList(); // Recarrega a lista completa
    });
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: AppColors.neutralBlack, // Cor de fundo da tela
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(120.0), // Altura da AppBar
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(top: 36.0), // Ajusta a distância da statusBar
          child: AppBar(
            backgroundColor: AppColors.neutralBlack,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0), // Margem superior do ícone
                child: IconButton(
                  icon: Icon(
                    Icons.document_scanner,
                    color: AppColors.primaryOrange,
                    size: 30.0,
                  ),
                  onPressed: () {
                    _logger.info('Document Scanner Pressionado');
                  },
                ),
              ),
            ],
            title: Padding(
              padding: const EdgeInsets.only(top: 16.0), // Margem superior do título
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(top: 5), // Margem superior de 5 pixels
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: ClipOval(
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(profileImageUrl),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14), // Espaçamento entre o avatar e o texto
                  Text(
                    greeting,
                    style: GoogleFonts.dmSans(
                      textStyle: const TextStyle(
                        color: AppColors.neutralWhite,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  const Spacer(), // Espaço que empurra os elementos à esquerda
                ],
              ),
            ),
          ),
        ),
      ),
    ),

      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 8.0), // Ajustando o padding superior
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 281,
                height: 49,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
                ),
                child: Text(
                  "Lista de Verificação",
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: AppColors.backgroundGreyLight,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.30,
                      letterSpacing: 0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // Reduzindo o espaço entre o título e o campo de pesquisa
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0), // Ajustando o padding vertical
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 49,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundDark2,
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Pesquisar',
                        hintStyle: GoogleFonts.dmSans(
                          textStyle: const TextStyle(
                            color: AppColors.neutralWhite,
                          ),
                        ),
                        filled: true,
                        fillColor: AppColors.backgroundDark2,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.neutralWhite,
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          color: AppColors.neutralWhite,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0), // Espaço entre o campo de pesquisa e o botão de filtro
                Container(
                  width: 49,
                  height: 49,
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Remix.filter_3_line,
                        color: AppColors.neutralWhite,
                        size: 28,
                      ),
                      onPressed: _toggleFilterVisibility,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12), // Ajustando o espaço entre o campo de pesquisa e a lista
          Expanded(
  child: ListView.builder(
    itemCount: checkLists.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChecklistDetailScreen(
                checklist: checkLists[index],
              ),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.backgroundDark2,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ajuste o Container do areaId para se ajustar ao texto
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(45),
                ),
                child: Text(
                  checkLists[index].areaName,
                  style: GoogleFonts.dmSans(
                    textStyle: const TextStyle(
                      color: AppColors.backgroundLight2,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                checkLists[index].title,
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    color: AppColors.neutralWhite,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Revisão: ${checkLists[index].revisionNumber}',
                style: GoogleFonts.dmSans(
                  textStyle: const TextStyle(
                    color: AppColors.neutralWhite,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  ),
),

          // Se o filtro estiver visível, exibe a seção de filtros
          if (_isFilterVisible)
            Container(
              color: AppColors.backgroundLight,
              padding: const EdgeInsets.all(16.0),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.5,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filtrar por setores',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.neutralBlack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Clique no setor que deseja adicionar ou remover da lista.',
                      style: GoogleFonts.dmSans(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColors.neutralBlack,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...List.generate(sectors.length, (index) {
                      return CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          sectors[index],
                          style: GoogleFonts.dmSans(
                            textStyle: const TextStyle(
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                        value: selectedSectors[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedSectors[index] = value!;
                          });
                        },
                        activeColor: AppColors.highlightGreen,
                        checkColor: AppColors.neutralBlack,
                      );
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _applyFilters,
                          child: Text(
                            "Aplicar Filtros",
                            style: GoogleFonts.dmSans(),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: _clearFilters,
                          child: Text(
                            "Limpar Filtros",
                            style: GoogleFonts.dmSans(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
