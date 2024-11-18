import 'package:flutter/material.dart'; 
import 'package:provider/provider.dart'; 
import '../model/lugar.dart'; 
import '../provider/paises_provider.dart'; // Importando o provider de países

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _imagemUrlController = TextEditingController();
  final TextEditingController _recomendacoesController = TextEditingController();
  final TextEditingController _avaliacaoController = TextEditingController();
  final TextEditingController _custoMedioController = TextEditingController();
  final List<String> _paisesSelecionados = [];

  @override
  Widget build(BuildContext context) {
    // Obtendo a lista de países do PaisesProvider
    final paises = Provider.of<PaisesProvider>(context).paises;

    // Gerando a lista de DropdownMenuItems a partir dos países no provider
    final List<DropdownMenuItem<String>> paisesDropdownItems = paises.map((pais) {
      return DropdownMenuItem<String>(
        value: pais.id,
        child: Text(pais.titulo),
      );
    }).toList();

    void _submitForm() {
      if (_formKey.currentState!.validate()) {
        // Obtém o provider de Lugares
        final lugaresProvider = Provider.of<PaisesProvider>(context, listen: false);

        // Criação de um novo lugar
        final novoLugar = Lugar(
          id: DateTime.now().toString(),
          paises: _paisesSelecionados, // Países selecionados agora são baseados no PaisesProvider
          titulo: _tituloController.text,
          imagemUrl: _imagemUrlController.text,
          recomendacoes: _recomendacoesController.text.split(','),
          avaliacao: double.parse(_avaliacaoController.text),
          custoMedio: double.parse(_custoMedioController.text),
        );

        // Adiciona o novo lugar no provider
        lugaresProvider.adicionarLugar(novoLugar);

        // Fecha a tela de cadastro
        Navigator.of(context).pop();

        // Exibe um Snackbar informando o sucesso da adição
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Novo lugar "${novoLugar.titulo}" adicionado!'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Lugar')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _tituloController,
                  decoration: InputDecoration(labelText: 'Título'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'O título é obrigatório';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _imagemUrlController,
                  decoration: InputDecoration(labelText: 'URL da Imagem'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'A URL da imagem é obrigatória';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _recomendacoesController,
                  decoration: InputDecoration(labelText: 'Recomendações (separe por vírgulas)'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Adicione pelo menos uma recomendação';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _avaliacaoController,
                  decoration: InputDecoration(labelText: 'Avaliação (0-5)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final avaliacao = double.tryParse(value ?? '');
                    if (avaliacao == null || avaliacao < 0 || avaliacao > 5) {
                      return 'Informe uma avaliação válida entre 0 e 5';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _custoMedioController,
                  decoration: InputDecoration(labelText: 'Custo Médio'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final custo = double.tryParse(value ?? '');
                    if (custo == null || custo < 0) {
                      return 'Informe um custo médio válido';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Selecione um País'),
                  items: paisesDropdownItems,
                  onChanged: (paisSelecionado) {
                    setState(() {
                      if (paisSelecionado != null && !_paisesSelecionados.contains(paisSelecionado)) {
                        _paisesSelecionados.add(paisSelecionado);
                      }
                    });
                  },
                  validator: (value) {
                    if (_paisesSelecionados.isEmpty) {
                      return 'Selecione pelo menos um país';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Wrap(
                  children: _paisesSelecionados
                      .map((paisId) {
                        final pais = paises.firstWhere((pais) => pais.id == paisId);
                        return Chip(
                          label: Text(pais.titulo),
                          onDeleted: () {
                            setState(() {
                              _paisesSelecionados.remove(paisId);
                            });
                          },
                        );
                      })
                      .toList(),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Cadastrar Lugar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
