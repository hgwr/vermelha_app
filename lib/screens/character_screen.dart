import 'package:flutter/material.dart';

import '../models/character.dart';
import '../models/job.dart';

class CharacterScreen extends StatefulWidget {
  static const routeName = '/character';

  CharacterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Character character = getInitializedCharacterByJob(Job.fighter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: character.id != null ? Text(character.name) : Text('New'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Text('Name: '),
                        Expanded(
                          child: TextField(
                            controller: TextEditingController(
                              text: character.name,
                            ),
                            onChanged: (value) {
                              character.name = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Job: '),
                        Expanded(
                          child: DropdownButton<Job>(
                            value: character.job,
                            onChanged: (Job? newValue) {
                              setState(() {
                                character.job = newValue!;
                              });
                            },
                            items: Job.values.map((Job job) {
                              return DropdownMenuItem<Job>(
                                value: job,
                                child: Text(job.toString().split('.').last),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Level: '),
                        Expanded(
                          child: Text(
                            character.level.toString(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
