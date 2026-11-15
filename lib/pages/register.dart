import 'package:flutter/material.dart';

// import 'package:gestionnary_task/models/users.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _StateRegister();
}

class _StateRegister extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  final List<Map<String, dynamic>> _listUserRegisters = [];
  // Récupérer le model User
  // final User user;

  // Récupération des données dans controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();

  // Récupération des données dans focus

  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final passwordConfirmFocus = FocusNode();

  // Méthode dipose()
  @override
  void dispose() {
    // Libère les controllers dans dispose()
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();

    // Libérer les focus dans dispose()
    firstNameFocus.dispose();
    lastNameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    passwordConfirmFocus.dispose();

    super.dispose();
  }

  void _showErrorMessage(String message) {
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

  // void _showSuccessMessage(String message) {
  //   ScaffoldMessenger.of(context)
  //     ..hideCurrentSnackBar()
  //     ..showSnackBar(
  //       SnackBar(
  //         content: Text(message),
  //         backgroundColor: Theme.of(context).colorScheme.success,
  //         behavior: SnackBarBehavior.floating,
  //         duration: const Duration(seconds: 3),
  //       ),
  //     );
  // }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    print('BOnjourr');

    String firstName = firstNameController.text.trim();
    String lastName = lastNameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String passwordConfirm = passwordConfirmController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      // print('ggfdfsdsd');
      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) {
        return;
      }

      // Ajouter l'utilisateur dans la liste des inscris
      _listUserRegisters.add({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'passwordConfirm': passwordConfirm,
      });

      print(_listUserRegisters);

      if (!mounted) {
        return;
      }

      // Vider les champs
      // clearInputIfValid();
      // Rediriger vers la page de connexion
      Navigator.pushReplacementNamed(context, '/login');
    } catch (e) {
      _showErrorMessage('Erreur survenue lors de l\'inscription');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Future<void> clearInputIfValid() async {
  //   try {
  //     await Future.delayed(const Duration(seconds: 2));

  //     firstNameController.clear();
  //     lastNameController.clear();
  //     emailController.clear();
  //     passwordController.clear();
  //     passwordConfirmController.clear();
  //   } catch (e) {
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Builder(
                      // Injects a fresh, lower-level context
                      builder: (builderContext) {
                        return ElevatedButton(
                          onPressed: () {
                            // SUCCESS: Use 'builderContext' instead of the top-level 'context'
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.chevron_left_rounded),
                        );
                      },
                    ),
                    Expanded(
                      child: Text(
                        'Register',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      icon: Icon(Icons.lock),
                      tooltip: 'Login',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: firstNameController,
                            focusNode: firstNameFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(lastNameFocus);
                            },
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Ce champs ne peut pas être vide";
                              }

                              if (value.length > 100) {
                                return 'Le prenom est trop long !';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextFormField(
                            controller: lastNameController,
                            focusNode: lastNameFocus,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (_) {
                              FocusScope.of(context).requestFocus(emailFocus);
                            },
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Ce champs ne peut pas être vide";
                              }

                              if (value.length > 100) {
                                return 'Le nom est trop long !';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
                      focusNode: emailFocus,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      focusNode: passwordFocus,
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context)
                            .requestFocus(passwordConfirmFocus);
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        // prefixIcon: Icon(Icons.lock),
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
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ce champs ne peut pas être vide";
                        }

                        if (value.length < 6) {
                          return '6 caractères minimum';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: passwordConfirmController,
                      obscureText: _obscurePasswordConfirm,
                      focusNode: passwordConfirmFocus,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePasswordConfirm = !_obscurePasswordConfirm;
                            });
                          },
                          icon: Icon(
                            _obscurePasswordConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ce champs ne peut pas être vide";
                        }

                        if (value.length < 6) {
                          return '6 caractères minimum';
                        }

                        if (value != passwordController.text) {
                          return 'Ce password ne correspond pas !';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
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
                            onPressed: () {
                              _register();
                            },
                            style: FilledButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: _isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                                    'Créer un compte',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium,
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 70),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            // Action de connexion
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
            ),
          ],
        ),
      ),
    );
  }
}
