// On importe les bibliothèques nécessaires
import 'dart:convert'; // Pour décoder la réponse JSON
import 'package:flutter/material.dart'; // Widgets Flutter
import 'package:http/http.dart' as http; // Pour faire les requêtes HTTP
import 'package:exo2/Models/article.dart'; // Modèle d'article
import 'package:exo2/Views/articlesdetails.dart'; // Vue des détails d’un article

// Widget principal qui gère l’affichage des articles avec pagination
class ArticlesController extends StatefulWidget {
  const ArticlesController({super.key});

  @override
  State<ArticlesController> createState() => _ArticlesControllerState();
}

// Classe d'état liée à ArticlesController
class _ArticlesControllerState extends State<ArticlesController> {
  final ScrollController _scrollController = ScrollController(); // Pour détecter quand on atteint le bas de la liste
  List<Article> _articles = []; // Liste des articles récupérés
  bool _isLoading = false; // Indique si un chargement est en cours
  bool _hasMore = true; // Indique s'il reste des articles à charger
  int _page = 0; // Compteur de page pour la pagination
  final int _limit = 10; // Nombre d’articles à charger par "page"

  @override
  void initState() {
    super.initState();
    _fetchArticles(); // Charge les premiers articles au démarrage

    // On ajoute un écouteur sur le scroll : quand on est proche du bas, on charge plus d’articles
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200 && // Marge de déclenchement
          !_isLoading &&
          _hasMore) {
        _fetchArticles(); // Appelle l’API pour charger plus
      }
    });
  }

  // Fonction pour charger les articles depuis l’API
  Future<void> _fetchArticles() async {
    if (_isLoading) return; // Si un chargement est déjà en cours, on ne fait rien

    setState(() {
      _isLoading = true; // Active le chargement
    });

    final start = _page * _limit; // Calcule le décalage pour l’URL
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts?_start=$start&_limit=$_limit');

    try {
      final response = await http.get(url); // Appel API

      if (!mounted) return; // On vérifie que le widget est toujours présent

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;

        if (data.isEmpty) {
          _hasMore = false; // Plus d’articles à venir
        } else {
          final newArticles = data.map((json) => Article.fromJson(json)).toList(); // Conversion JSON → Article
          _articles.addAll(newArticles); // On ajoute à la liste existante
          _page++; // On passe à la page suivante
        }
      } else {
        print('Erreur serveur : ${response.statusCode}'); // Erreur HTTP
      }
    } catch (e) {
      print('Erreur de chargement : $e'); // Autre erreur (réseau, etc.)
    }

    if (mounted) {
      setState(() {
        _isLoading = false; // Fin de chargement
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Libère la mémoire liée au scroll
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')), // Barre du haut

      body: ListView.builder(
        controller: _scrollController, // Connecte le scroll
        itemCount: _articles.length + (_hasMore ? 1 : 0), // +1 pour afficher le loader si nécessaire
        itemBuilder: (context, index) {
          if (index < _articles.length) {
            final article = _articles[index]; // Récupère l’article
            return ListTile(
              title: Text(article.title), // Affiche le titre
              onTap: () {
                // Ouvre la page ArticleDetails au clic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ArticleDetails(article: article),
                  ),
                );
              },
            );
          } else {
            // Affiche le loader en bas de la liste
            return const Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
