// On importe les widgets Flutter
import 'package:flutter/material.dart';

// Widget statique (ne change pas) représentant la page "À propos"
class AboutPage extends StatelessWidget {
  const AboutPage({super.key}); // Constructeur sans paramètres

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar en haut de l'écran avec un titre
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('A Propos'), // Titre de la page
          ],
        ),
      ),

      // Corps de la page centré verticalement et horizontalement
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Utilise l’espace minimum vertical
          children: [
            Text('Contenu de la page'), // Premier texte

            SizedBox(height: 10), // Petit espace entre les textes

            Text('Élément de texte juste en dessous'), // Deuxième texte

            // Image en bas, agrandie automatiquement pour s'adapter à l'espace
            Expanded(
              child: FittedBox(
                child: Image.asset('assets/jj.jpg'), // Image locale (dans assets)
              ),
            ),
          ],
        ),
      ),
    );
  }
}
