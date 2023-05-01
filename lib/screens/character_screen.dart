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
                  shrinkWrap: true,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration:
                                const InputDecoration(labelText: 'Name'),
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
                    SizedBox(
                      height: 60,
                      child: Row(
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
                                  child: Text(job.name),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Text('Level: '),
                          Expanded(
                            child: Text(
                              character.level.toString(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Text('Max HP: '),
                          Expanded(
                            child: Text(
                              character.maxHp.toString(),
                            ),
                          ),
                        ],
                      ),
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
