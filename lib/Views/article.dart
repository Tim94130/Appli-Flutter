// On importe les bibliothèques nécessaires
import 'package:flutter/material.dart'; // Widgets Flutter
import 'package:exo2/Models/article.dart'; // Modèle Article
import 'package:exo2/Views/articlesdetails.dart'; // Vue de détails pour un article

// Widget qui affiche une liste d’articles
class ArticlesPage extends StatelessWidget {
  // Liste d'articles à afficher
  final List<Article> articles;

  // Constructeur : on exige une liste d’articles
  const ArticlesPage({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar en haut de la page
      appBar: AppBar(title: const Text('Articles')),

      // Corps de la page : une liste scrollable des articles
      body: ListView.builder(
        itemCount: articles.length, // Nombre total d’articles
        itemBuilder: (context, index) {
          final article = articles[index]; // On récupère l’article courant

          // Chaque élément est une tuile (ListTile) cliquable
          return ListTile(
            title: Text(article.title), // Affiche uniquement le titre
            onTap: () {
              // Lorsqu’on clique, on ouvre la page ArticleDetails
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetails(article: article),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
