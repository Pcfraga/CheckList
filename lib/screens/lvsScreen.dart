import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp()); // Inicializa o app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CheckList',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LvsScreen(), // Define a tela inicial como LvsScreen
    );
  }
}

class LvsScreen extends StatefulWidget {
  const LvsScreen({super.key});

  @override
  _LvsScreenState createState() => _LvsScreenState();
}

class _LvsScreenState extends State<LvsScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Lista fictícia de itens para exibição
  List<Map<String, dynamic>> items = [
    {
      'title': '1. Produtos Químicos',
      'subtitle': '1.1 Armazenamento',
      'question': 'Existe local de armazenamento?',
      'status': '', // Status inicial vazio
    },
    {
      'title': '2. Equipamentos de Proteção',
      'subtitle': '2.1 Máscaras',
      'question': 'Máscaras estão disponíveis?',
      'status': '', // Status inicial vazio
    },
    {
      'title': '3. Materiais de Limpeza',
      'subtitle': '3.1 Produtos',
      'question': 'Produtos de limpeza estão armazenados corretamente?',
      'status': '', // Status inicial vazio
    },
    // Outros itens podem ser adicionados aqui
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Verificação',
          style: GoogleFonts.dmSans(), // Fonte personalizada para AppBar
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Barra de pesquisa com o status de conclusão e o indicador circular
            Container(
              height: 49,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 233, 214, 214),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                children: [
                  // Indicador circular de progresso (carregando)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      value: 2 / 20, // Exemplo de progresso (2 de 20)
                      strokeWidth: 4,
                      color: Colors.white,
                      backgroundColor: const Color.fromARGB(255, 105, 82, 220),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      readOnly: true, // Desabilita a edição do texto
                      decoration: InputDecoration(
                        hintText:
                            'Concluídas 2 de 20', // Texto de status fictício
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 22, 19, 19),
                        ),
                        border: InputBorder.none,
                      ),
                      style: GoogleFonts.dmSans(
                        color: Colors.white,
                      ), // Aplicando fonte
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Lista dinâmica de itens
            Expanded(
              child: ListView.builder(
                itemCount: items.length, // Define o número de itens
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título principal (dinâmico)
                        Text(
                          items[index]['title'], // Exibe o título do item
                          style: GoogleFonts.dmSans(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Subtítulo (dinâmico)
                        Text(
                          items[index]['subtitle'], // Exibe o subtítulo do item
                          style: GoogleFonts.dmSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Pergunta (dinâmica)
                        Text(
                          items[index]['question'], // Exibe a pergunta do item
                          style: GoogleFonts.dmSans(fontSize: 18),
                        ),
                        const SizedBox(height: 20),

                        // Título para o status do item
                        Text(
                          'Status do item:',
                          style: GoogleFonts.dmSans(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Linha com os botões de status (C, NA, NC)
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center, // Centraliza os botões
                          children: [
                            // Botão "C" (Conforme)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  items[index]['status'] =
                                      'C'; // Marca como "Conforme"
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    items[index]['status'] == 'C'
                                        ? Colors
                                            .green // Cor verde se o status for "C"
                                        : Colors
                                            .grey, // Cor cinza se não for "C"
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ), // Menos arredondado
                                ),
                              ),
                              child: Text(
                                'C',
                                style: GoogleFonts.dmSans(),
                              ), // Aplicando fonte
                            ),

                            const SizedBox(width: 20),

                            // Botão "NA" (Não aplicável)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  items[index]['status'] =
                                      'NA'; // Marca como "Não aplicável"
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    items[index]['status'] == 'NA'
                                        ? Colors
                                            .blue // Cor azul se o status for "NA"
                                        : Colors
                                            .grey, // Cor cinza se não for "NA"
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ), // Bordas menos arredondadas
                                ),
                              ),
                              child: Text(
                                'NA',
                                style: GoogleFonts.dmSans(),
                              ), // Aplicando fonte
                            ),

                            const SizedBox(width: 10),

                            // Botão "NC" (Não conforme)
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  items[index]['status'] =
                                      'NC'; // Marca como "Não conforme"
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    items[index]['status'] == 'NC'
                                        ? Colors
                                            .red // Cor vermelha se o status for "NC"
                                        : Colors
                                            .grey, // Cor cinza se não for "NC"
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    6,
                                  ), // Bordas menos arredondadas
                                ),
                              ),
                              child: Text(
                                'NC',
                                style: GoogleFonts.dmSans(),
                              ), // Aplicando fonte
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Título
                            Text(
                              'Informações adicionais',
                              style: GoogleFonts.dmSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ), // Espaço entre o título e os ícones

                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment
                                      .center, // Centraliza os ícones
                              children: [
                                // Ícone de câmera
                                IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        3,
                                      ), // Menos arredondamento
                                      color:
                                          Colors
                                              .transparent, // Você pode definir uma cor se desejar
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                    ), // Ícone da câmera
                                  ),
                                  onPressed: () {
                                    print('Abrir câmera');
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ), // Espaço entre os ícones
                                // Ícone de mensagem
                                IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        3,
                                      ), // Menos arredondamento
                                      color:
                                          Colors
                                              .transparent, // Você pode definir uma cor se desejar
                                    ),
                                    child: Icon(
                                      Icons.message,
                                    ), // Ícone de mensagem
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        String message = '';
                                        return AlertDialog(
                                          title: Text(
                                            'Enviar Mensagem',
                                            style: GoogleFonts.dmSans(),
                                          ),
                                          content: TextField(
                                            onChanged: (value) {
                                              message =
                                                  value; // Armazena a mensagem digitada
                                            },
                                            decoration: InputDecoration(
                                              hintText: "Digite sua mensagem",
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                print(
                                                  'Mensagem enviada: $message',
                                                );
                                                Navigator.of(
                                                  context,
                                                ).pop(); // Fecha o dialog
                                              },
                                              child: Text(
                                                'Enviar',
                                                style: GoogleFonts.dmSans(),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(
                                                  context,
                                                ).pop(); // Fecha o dialog sem enviar
                                              },
                                              child: Text(
                                                'Cancelar',
                                                style: GoogleFonts.dmSans(),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ), // Espaço entre os ícones
                                // Ícone de aviso
                                IconButton(
                                  icon: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                        3,
                                      ), // Menos arredondamento
                                      color:
                                          Colors
                                              .transparent, // Você pode definir uma cor se desejar
                                    ),
                                    child: Icon(
                                      Icons.warning,
                                    ), // Ícone de aviso
                                  ),
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Atenção: Verifique as informações!',
                                          style: GoogleFonts.dmSans(),
                                        ),
                                        duration: Duration(seconds: 2),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Exibe o status selecionado (dinâmico)
                        Text(
                          'Status selecionado: ${items[index]['status']}',
                          style: GoogleFonts.dmSans(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
