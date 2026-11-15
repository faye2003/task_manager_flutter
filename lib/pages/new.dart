import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Ma page d\'accueil', home: HomePage()));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page Accueil')),
      body: Center( child: SelectOption()),
    );
  }
}

class SelectOption extends StatefulWidget {
  const SelectOption ({super.key});

  @override
  State<StatefulWidget> createState() => _StateSelectOption();
}

class _StateSelectOption extends State<SelectOption> {

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _navigateAndDisplaySelection(context);
      }, 
      child: Text('Go to select option')
    );
  }

  Future<void> _navigateAndDisplaySelection(BuildContext context) async {

    final result = await Navigator.push(
      context,
      MaterialPageRoute<String>(builder: (context) => const SelectScreen())
    );

    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class SelectScreen extends StatelessWidget {
  const SelectScreen ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('AppBar Option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'yes');
                },
                child: Text('Yes'),
              ),
            ),

             Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, 'No');
                },
                child: Text('No'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}