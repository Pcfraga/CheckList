// Importando bibliotecas necessárias
import 'package:checklist/screens/lvsScreen.dart'; // Importa a tela LvsScreen
import 'package:flutter/material.dart'; // Importa widgets do Flutter
import 'package:checklist/data/models/getAllCheckList_model.dart'; // Importa o modelo de dados
import 'package:google_fonts/google_fonts.dart'; // Importa fonts

// Classe ChecklistDetailScreen que estende StatelessWidget (sem estado)
class ChecklistDetailScreen extends StatelessWidget {
  // Declaração de uma variável final do tipo GetAllCheckListModelsDTO chamada checklist
  final GetAllCheckListModelsDTO checklist;

  // Construtor da classe que recebe o checklist como parâmetro
  const ChecklistDetailScreen({required this.checklist, super.key});

  @override
  Widget build(BuildContext context) {
    // Método que constrói a interface do usuário
    return Scaffold(
      // Scaffold fornece uma estrutura básica para layout
      appBar: AppBar(
        title: Text(
          'Detalhes da LV', // Título fixo na AppBar
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(color: const Color.fromARGB(238, 5, 4, 14)),
          ),
        ),
        actions: [
          // Lista de ações na AppBar (neste caso um botão)
          TextButton(
            onPressed: () {
              // Ação do botão "Baixar"
              print("Baixar clicado"); // Imprime no console quando clicado
            },
            child: Text(
              'Baixar', // Texto exibido no botão
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  color: const Color.fromARGB(255, 67, 29, 173),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 10), // Espaçamento entre o texto e o botão
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // Adiciona padding em torno do corpo
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Alinhamento das colunas à esquerda
          children: [
            // Exibe informações sobre o checklist
            Text(
              'Título: ${checklist.title}', // Mostra o título
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8), // Espaçamento entre os textos
            Text(
              'Área ID: ${checklist.areaId}', // Mostra o ID da área
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 8), // Espaçamento entre os textos
            Text(
              'Área: ${checklist.areaName}', // Mostra o nome da área
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(height: 8), // Espaçamento entre os textos
            Text(
              'Revisão: ${checklist.revisionNumber}', // Mostra o número da revisão
              style: GoogleFonts.dmSans(
                textStyle: TextStyle(color: Colors.black),
              ),
            ),
            const Spacer(), // Isso vai empurrar o próximo componente (botão) para o final da tela
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          bottom: 16,
        ), // Margem nas laterais e inferior
        child: ElevatedButton(
          onPressed: () {
            // Ação do botão "Iniciar"
            print("Iniciar clicado"); // Imprime no console quando clicado

            // Navegar para a tela LvsScreen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (context) =>
                        const LvsScreen(), // Navega para a tela LvsScreen
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 242, 92, 1),
            // Cor de fundo do botão
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ), // Padding superior e inferior
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0), // Bordas arredondadas
            ),
            minimumSize: Size(300, 49), // Tamanho mínimo do botão
          ),
          child: Text(
            'Iniciar', // Texto exibido no botão
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
