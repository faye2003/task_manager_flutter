// import 'package:material_ui/material_ui.dart';
import 'package:flutter/material.dart';
import 'package:gestionnary_task/pages/add_task.dart';
// import 'package:gestionnary_task/pages/detail.dart';
import 'package:gestionnary_task/pages/edit.dart';

enum Actions { delete, edit, share, archive, more }

class Task {
  final int id;
  final String titre;
  final String description;
  final String statut;
  final String propriety;

  Task({
    required this.id,
    required this.titre,
    required this.description,
    required this.propriety,
    required this.statut,
  });
}

class ListTask extends StatefulWidget {
  const ListTask({super.key});

  @override
  State<ListTask> createState() => _StateListTask();
}

class _StateListTask extends State<ListTask> {
  final List<Map<String, dynamic>> _tasks = [
    {
      "id": 1,
      'title': 'Apprendre les bases de Flutter',
      'description': 'Ici une description sur les bases de Flutter',
      'propriety': 'Avancement',
      'statut': 'Terminée',
    },
    {
      "id": 2,
      'title': 'Apprendre les bases de Dart',
      'description': 'Ici une description sur les bases de Dart',
      'propriety': 'Avancement',
      'statut': 'Terminée',
    },
  ];

  List<Map<String, dynamic>> _filterListTasks = [];
  final TextEditingController _searchText = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filterListTasks = _tasks;
    _searchText.addListener(_filterTask);

  }

  @override
  void dispose() {
    _searchText.dispose();
    super.dispose();
  }

  void _filterTask () {
    final lowerQuery = _searchText.text.toLowerCase();
    setState(() {
      _filterListTasks = _tasks.where((task) {
        final title = task['title'].toString().toLowerCase();
        return title.contains(lowerQuery);
      }).toList();
    });
  }

  Future<void> _openAddPage() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute<Map<String, dynamic>>(
        builder: (context) => const AddTask(),
      ),
    );

    if (result != null) {
      setState(() {
        // Ajouter les données à ta liste
        _filterListTasks.add(result);
      });
    }
  }

  // On your main/list page
  Future<void> _navigateToEditTask(Map<String, dynamic> taskToEdit, int index) async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditTask(task: taskToEdit)),
    );

    // Check if a result was returned
    if (updatedTask != null && updatedTask is Map<String, dynamic>) {
      setState(() {
        // Option A: Update by index if known
        _filterListTasks[index] = updatedTask;
      });
    }
  }

  // Méthode pour supprimer une tâche
  Future<void> _deleteTask(int index) async {
    // Récupérer le titre de tâche à supprimer
    final result = _filterListTasks[index]['title'];
    // Réécupérer la liste des tâches
    final tasks = _filterListTasks;
    // vérifier si le tâche existe == le titre n'est pas null
    if (result != null) {
      setState(() {
        tasks.removeWhere((tasks) => tasks['title'] == result);
      });
    }
  }

  List<Map<String, dynamic>> searchTask(String query) {
    final lowerQuery = query.toLowerCase();
    return _tasks.where((task) {
      final title = task['title'].toString().toLowerCase();
      return title.contains(lowerQuery);
    }).toList();
  }

  List<Map<String, dynamic>> filterTask (bool Function(Map<String, dynamic>) condition) {
    return _tasks.where(condition).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchText,
          onSubmitted: (_) => _filterTask(),
          decoration: InputDecoration(
            labelText: 'Rechercher une tâche',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
            prefixIcon: Icon(Icons.search),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        ],
      ),

      // Corps de la page avec la liste des tâches (à compléter selon vos besoins)
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Builder(
            builder: (context) {
              return ListView.builder(
                itemCount: _filterListTasks.length, // Nombre de tâches à afficher
                itemBuilder: (context, index) {
                  final item = _filterListTasks[index];
                  return Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: Icon(Icons.check_circle_outline),
                          title: Text(
                            item['title'] ?? 'Pas de Titre',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          subtitle: Text(
                            item['description'] ?? 'Pas de Description',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: Actions.delete,
                                child: Text('Supprimer'),
                                onTap: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                            'Supprimer la tâche',
                                          ),
                                          content: const Text(
                                            'Êtes-vous sûr de vouloir supprimer cette tâche ?',
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () => Navigator.pop(
                                                context,
                                                'Cancel',
                                              ),
                                              child: const Text('Annuler'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                _deleteTask(index);
                                                Navigator.pop(context, 'OK');
                                                ScaffoldMessenger.of(context)
                                                  // .showSnackBar(
                                                  //   SnackBar(
                                                  //     content: const Text(
                                                  //       'Tâche supprimée !',
                                                  //     ),
                                                  //     action: SnackBarAction(
                                                  //       label: 'Fermer',
                                                  //       onPressed: () {},
                                                  //     ),
                                                  //   ),
                                                  // );
                                                  ..hideCurrentSnackBar()
                                                  ..showSnackBar(
                                                    SnackBar(
                                                      content: const Text(
                                                        'Tâche supprimée avec succès !',
                                                      ),
                                                      backgroundColor:
                                                          Colors.green,
                                                      behavior: SnackBarBehavior
                                                          .fixed,
                                                      duration: const Duration(
                                                        seconds: 3,
                                                      ),
                                                      // action: SnackBarAction(label: 'Fermer', onPressed: () {}),
                                                    ),
                                                  );
                                              },
                                              child: const Text('Oui'),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                              ),
                              PopupMenuItem(
                                value: Actions.edit,
                                onTap: () => _navigateToEditTask(item, index),
                                child: Text('Modifier'),
                              ),
                              const PopupMenuItem(
                                value: Actions.share,
                                child: Text('Partager'),
                              ),
                              const PopupMenuItem(
                                value: Actions.archive,
                                child: Text('Archiver'),
                              ),
                              const PopupMenuItem(
                                value: Actions.more,
                                child: Text('Plus'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: Text(
                                'DÉTAILS',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) =>
                                //         DetailTaskPage(list: list[index]),
                                //   ),
                                // );
                              },
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: Text(
                                'TERMINER',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              onPressed: () {
                                /* ... */
                              },
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),

      // Bouton d'action flottant pour ajouter une tâche
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
