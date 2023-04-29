import 'package:flutter/material.dart';

import '../models/character.dart';
import '../models/job.dart';

class CharacterScreen extends StatefulWidget {
  static const routeName = '/character';

  Character? character;

  CharacterScreen({
    Key? key,
    this.character,
  }) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Character')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.character?.name ?? ''),
            widget.character?.job != null
                ? getImageByJob(widget.character!.job!)
                : Container(),
          ],
        ),
      ),
    );
  }
}
