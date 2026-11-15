import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() => _StateLogin();
}

class _StateLogin extends State<Login> {

  final _formKey = GlobalKey<FormState>();
  // final data = TextEditingController();
  final TextEditingController _loginController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    // data.dispose();
    super.dispose();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
        ),
      );
  }

  Future<void> _login() async {

    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Récupération des valeurs saisies
    String login = _loginController.text.trim();
    String password = _passwordController.text;

    // Vérification des champs vides
    if (login.isEmpty || password.isEmpty) {
      _showMessage('Veuillez renseigner tous les champs.');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulation d'une connexion
      await Future.delayed(const Duration(seconds: 2));

      // Identifiants de démonstration
      const validLogin = 'admin@gmail.com';
      const validPassword = 'faye22';

      if (login == validLogin && password == validPassword) {
        if (!mounted) return;

        // Connexion réussie : redirection vers HomePage
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showMessage('Login ou mot de passe incorrect.');
      }
    } catch (e) {
      _showMessage('Une erreur est survenue lors de la connexion.');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login', style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 20),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: _loginController,
                      decoration: InputDecoration(
                        labelText: 'Nom d\'utilisateur',
                        hintText: 'Entrez votre nom',
                        prefixIcon: Icon(
                          Icons.person_outline_sharp,
                        ), // Icône utilisateur au début du champ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      validator: (value) {
                        final email = value?.trim() ?? '';

                        if (value == null || value.isEmpty) {
                          return "Ce champs ne peut pas être vide";
                        }

                        if (email.isEmpty) {
                          return 'Email obligatoire';
                        }

                        if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$')
                            .hasMatch(email)) {
                          return 'Adresse email invalide';
                        }

                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Mot de Passe',
                        hintText: 'Entrez votre mot de passe',
                        prefixIcon: Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ), // Icône utilisateur au début du champ
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ce champs ne peut pas être vide";
                        }
                        return null;
                      },
                    ),
                  ),

                  SizedBox(height: 20),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ],
                        ),
                        child: FilledButton(
                          onPressed: _isLoading ? null : _login,
                          style: ElevatedButton.styleFrom(
                            // backgroundColor: Colors.transparent,
                            // shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  'Se connecter',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Action de connexion
                  },
                  child: Text(
                    'Mot de passe oublié ?',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),

            SizedBox(height: 100),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Action de connexion
                  },
                  child: Text(
                    'Se connecter avec',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    print('Bouton cliqué !');
                  },
                  icon: Icon(Icons.facebook),
                  label: Text('Facebook'),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.favorite),
                  label: Text('google'),
                  iconAlignment:
                      IconAlignment.start, // Place l'icône à droite du texte
                ),
              ],
            ),

            SizedBox(height: 10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    // Action de connexion
                    Navigator.pushNamed(context, '/register');
                  },
                  child: Text(
                    'Vous n\'avez pas un compte ? s\'inscrire',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
