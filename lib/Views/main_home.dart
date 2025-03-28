// On importe les bibliothèques nécessaires à l’interface, aux vues et aux contrôleurs
import 'package:flutter/material.dart';
import 'package:exo2/Controllers/ArticlesControllers.dart';
import 'package:exo2/Views/contact.dart';
import 'package:exo2/Views/about.dart';

// Widget principal de la page d’accueil
class HomeView extends StatelessWidget {
  // Indique si le mode sombre est activé
  final bool isDarkMode;

  // Fonction à appeler quand on change le thème (Switch)
  final void Function(bool) onToggleTheme;

  // Constructeur avec paramètres requis
  const HomeView({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar en haut de l'écran avec le titre
      appBar: AppBar(
        title: const Text('Portfolio'),
      ),

      // Drawer = menu latéral (à gauche)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Aucun padding autour des éléments
          children: <Widget>[
            // En-tête du menu avec fond bleu et titre blanc
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),

            // Élément : lien vers la page Contact
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.pop(context); // Ferme le menu
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ContactPage()),
                ); // Va vers la page Contact
              },
            ),

            // Élément : lien vers la page À Propos
            ListTile(
              title: const Text('À Propos'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                ); // Va vers la page À propos
              },
            ),

            // Élément : lien vers la page Articles (avec pagination)
            ListTile(
              title: const Text('Articles'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ArticlesController()),
                ); // Va vers la liste des articles
              },
            ),

            // Élément : switch pour activer/désactiver le thème sombre
            SwitchListTile(
              title: const Text('Mode sombre'),
              value: isDarkMode,            // valeur actuelle du switch
              onChanged: onToggleTheme,     // fonction à appeler si on change
              secondary: const Icon(Icons.brightness_6), // icône à gauche
            ),
          ],
        ),
      ),

      // Corps principal de la page : texte centré
      body: const Center(
        child: Text(
          'Bienvenue sur mon portfolio !',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
