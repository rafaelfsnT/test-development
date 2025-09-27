import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/search_result_model.dart';
import '../service/search_api_service.dart';
import 'widgets/search_bar.dart'; // Importa o novo widget
import 'widgets/result_card.dart'; // Importa o novo widget

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final SearchApiService _apiService = SearchApiService();
  List<SearchResultModel> _results = [];
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _results = [];
    });

    try {
      final results = await _apiService.search(query);
      setState(() {
        _results = results;
        _isLoading = false;
        if (results.isEmpty) {
          _errorMessage = "A busca não retornou resultados. Tente outro termo.";
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString().replaceFirst('Exception: ', 'Erro: ');
        _isLoading = false;
      });
    }
  }

  // Função para abrir o link (extraída para ser chamada facilmente)
  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o link: $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API de Pesquisa (Flutter)'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            isLoading: _isLoading,
            onSearch: _performSearch,
          ),

          Expanded(child: _buildResultsContainer()),
        ],
      ),
    );
  }

  Widget _buildResultsContainer() {
    if (_isLoading) {
      return const Center(child: Text('Processando Web Scraping...'));
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
        ),
      );
    }

    if (_results.isEmpty) {
      return const Center(child: Text('Nenhum resultado para exibir.'));
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final result = _results[index];
        return ResultCard(
          result: result,
          onLinkTap: _launchUrl, // Passa a função de abrir o link como callback
        );
      },
    );
  }
}
