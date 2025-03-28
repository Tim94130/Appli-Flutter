// On importe les bibliothèques nécessaires
import 'package:flutter/material.dart'; // Pour créer l’interface utilisateur
import 'package:shared_preferences/shared_preferences.dart'; // Pour sauvegarder les données localement dans l’appareil

// Widget ContactPage : c’est une page avec un formulaire, donc on utilise StatefulWidget
class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

// Classe qui gère l’état de la page (contenu du formulaire, interactions, etc.)
class _ContactPageState extends State<ContactPage> {
  // Contrôleurs pour les champs de texte : ils permettent de lire ou modifier le contenu des champs
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Dès que la page se lance, on tente de charger les données enregistrées localement
  }

  // Cette fonction charge les données enregistrées précédemment avec SharedPreferences
  Future<void> _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance(); // Accès aux préférences partagées
    setState(() {
      // On met à jour les champs avec les valeurs stockées (ou vide si rien)
      nameController.text = prefs.getString('contact_name') ?? '';
      emailController.text = prefs.getString('contact_email') ?? '';
      messageController.text = prefs.getString('contact_message') ?? '';
    });
  }

  // Fonction appelée quand on clique sur "Envoyer" : elle enregistre localement les données
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance(); // Accès aux préférences
    // On sauvegarde chaque champ avec une clé
    await prefs.setString('contact_name', nameController.text);
    await prefs.setString('contact_email', emailController.text);
    await prefs.setString('contact_message', messageController.text);

    // Message de confirmation affiché en bas de l’écran
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Formulaire sauvegardé localement')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre en haut avec le titre "Contact"
      appBar: AppBar(
        title: const Text('Contact'),
      ),
      // Corps de la page avec padding autour
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Permet de faire défiler la page si le clavier est ouvert
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Aligne les champs à gauche
            children: [
              const Text(
                'Nous sommes à votre écoute pour répondre à vos questions.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20), // Espace entre les éléments

              // Champ pour entrer le nom
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Votre nom',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Champ pour entrer l’email
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress, // Clavier adapté pour email
                decoration: const InputDecoration(
                  labelText: 'Votre email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Champ pour écrire un message (multiligne)
              TextField(
                controller: messageController,
                maxLines: 5, // Plus grand champ
                decoration: const InputDecoration(
                  labelText: 'Votre message',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              // Bouton "Envoyer", centré horizontalement
              Center(
                child: ElevatedButton(
                  onPressed: _saveData, // Sauvegarde les données quand on clique
                  child: const Text('Envoyer'), // Texte affiché dans le bouton
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
