import 'package:flutter/material.dart';
import 'package:vermelha_app/screens/edit_priority_parameters_screen.dart';

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
                child: createListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView createListView() {
    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: getImageByJob(character.job!),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                decoration: const InputDecoration(labelText: 'Name'),
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
                      character = getInitializedCharacterByJob(character.job!);
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
        characterPropertyItem(
          'Level: ',
          character.level.toString(),
        ),
        characterPropertyItem(
          'HP: ',
          "${character.hp} / ${character.maxHp}",
        ),
        characterPropertyItem(
          'MP: ',
          "${character.mp} / ${character.maxMp}",
        ),
        characterPropertyItem('Attack: ', character.attack.toString()),
        characterPropertyItem('Defense: ', character.defense.toString()),
        characterPropertyItem('Magic Power: ', character.magicPower.toString()),
        characterPropertyItem('Speed: ', character.speed.toString()),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              EditPriorityParametersScreen.routeName,
              arguments: character,
            );
          },
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Text('Priority Parameters: '),
                Expanded(
                  child: Text(
                    character.priorityParameters
                        .map((e) => e.name)
                        .toList()
                        .join(', '),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox characterPropertyItem(String label, String value) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Text(label),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
