// On importe les bibliothèques nécessaires
import 'package:flutter/material.dart'; // Widgets de base Flutter
import 'package:exo2/Models/article.dart'; // Modèle Article (contenant titre, body, etc.)

// Ce widget affiche les détails d’un article cliqué depuis la liste
class ArticleDetails extends StatelessWidget {
  // L’article à afficher est passé en paramètre
  final Article article;

  // Constructeur obligatoire avec un article requis
  const ArticleDetails({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre du haut avec le titre de l’article
      appBar: AppBar(title: Text(article.title)),

      // Corps de la page avec un padding autour du texte
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Marge intérieure
        child: Text(article.body), // Affiche le contenu de l’article
      ),
    );
  }
}
