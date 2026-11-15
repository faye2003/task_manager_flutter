import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTask extends StatefulWidget {
  const EditTask({super.key, required this.task});
  final Map<String, dynamic> task;

  @override
  State<StatefulWidget> createState() => _StateEditTask();
}

class _StateEditTask extends State<EditTask> {
  final TextEditingController _titleControl = TextEditingController();
  final TextEditingController _descriptionControl = TextEditingController();
  // Track the selected value
  String? _selectedValue;

  final List<String> options = ['Faible', 'Moyenne', 'Élevée'];

  final TextEditingController _selectedDate = TextEditingController();

  @override
  void dispose() {
    _selectedDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2024, 7, 25),
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _editTask() {
    // Create a new map with updated values while preserving the original ID/metadata
    final updatedTask = Map<String, dynamic>.from(widget.task);
    updatedTask['title'] = _titleControl.text;
    updatedTask['description'] = _descriptionControl.text;
    updatedTask['propriety'] = _selectedValue ?? "Aucune valeur";
    updatedTask['statut'] = _selectedDate.text;

    // Pop and return the updated map back to the previous screen
    Navigator.pop(context, updatedTask);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Tâche modifiée avec succès !'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 3),
          // action: SnackBarAction(label: 'Fermer', onPressed: () {}),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Modifier une tâche',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Titre de la tâche'),
              SizedBox(height: 20),
              TextField(
                controller: _titleControl,
                onSubmitted: (_) => _editTask(),
                decoration: InputDecoration(
                  labelText: 'Entrez le titre',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Text('Description de la tâche'),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionControl,
                onSubmitted: (_) => _editTask(),
                decoration: InputDecoration(
                  labelText: 'Description de la tâche',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
              SizedBox(height: 20),
              const Text('Statut de la tâche'),
              SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  // 2. Set the current value shown on the button
                  value: _selectedValue,
                  hint: const Text('Select an option'),
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  elevation: 16,
                  borderRadius: BorderRadius.circular(15),
                  dropdownColor: Theme.of(context).colorScheme.onSecondary,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  // 3. Map your list of items to a list of DropdownMenuItems
                  items: options.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        children: [
                          const Icon(Icons.label_outline, size: 20, color: Colors.blueAccent),
                          const SizedBox(width: 10,),
                          Text(item)
                        ],
                      ),
                    );
                  }).toList(),
                  // 4. Update the state when the user selects a new item
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedValue = newValue;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisSize: .min,
                spacing: 20,
                children: <Widget>[
                  TextField(
                    controller: _selectedDate,
                    readOnly: true, // Empêche l'utilisateur de taper du texte manuellement
                    decoration: const InputDecoration(
                      labelText: 'Sélectionnez une date',
                      hintText: 'Sélectionnez une date',
                      suffixIcon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed:
                    _editTask, // Ajouter la logique pour enregistrer la tâche
                child: Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
