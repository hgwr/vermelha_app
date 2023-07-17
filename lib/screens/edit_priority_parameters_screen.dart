import 'package:flutter/material.dart';

import '../models/player_character.dart';
import '../models/job.dart';
import '../models/status_parameter.dart';

class EditPriorityParametersScreen extends StatefulWidget {
  static const routeName = '/edit-priority-parameters';

  const EditPriorityParametersScreen({super.key});

  @override
  State<EditPriorityParametersScreen> createState() =>
      _EditPriorityParametersScreenState();
}

class _EditPriorityParametersScreenState
    extends State<EditPriorityParametersScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  PlayerCharacter character = getInitializedCharacterByJob(Job.fighter);

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      character = ModalRoute.of(context)!.settings.arguments as PlayerCharacter;
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop(character);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: character.id != null ? Text(character.name) : const Text('New'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'このキャラクターがレベルアップした時、'
                              '優先的に成長するパラメーターを３つ選びます',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                        ],
                      ),
                      ...statusParameters.map(
                        (e) {
                          return Row(
                            children: [
                              Expanded(
                                child: CheckboxListTile(
                                  title: Text(e.name),
                                  value:
                                      character.priorityParameters.contains(e),
                                  onChanged: (bool? value) {
                                    setState(() {
                                      if (value == true) {
                                        if (character
                                                .priorityParameters.length >=
                                            3) {
                                          character.priorityParameters
                                              .removeAt(0);
                                        }
                                        character.priorityParameters.add(e);
                                      } else {
                                        character.priorityParameters.remove(e);
                                      }
                                    });
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
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
