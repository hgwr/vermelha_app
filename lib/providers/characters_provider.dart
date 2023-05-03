import 'package:flutter/material.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/repository/character_repository.dart';

class CharactersProvider extends ChangeNotifier {
  List<Character> _characters = [];

  final CharacterRepository _characterRepository = CharacterRepository();

  List<Character> get characters => _characters;

  Future<void> loadCharacters() async {
    _characters = await _characterRepository.findAll();
    notifyListeners();
  }

  Future<Character> addCharacter(Character character) async {
    final c = await _characterRepository.save(character);
    _characters.add(c);
    notifyListeners();
    return c;
  }

  Future<void> removeCharacter(Character character) async {
    debugPrint("removing character ${character.name}");
    _characters.remove(character);
    int count = await _characterRepository.delete(character);
    debugPrint("removed $count character");
    notifyListeners();
  }

  Future<Character> updateCharacter(Character character) async {
    final index = _characters.indexWhere((c) => c.id == character.id);
    _characters[index] = character;
    final c = await _characterRepository.update(character);
    notifyListeners();
    return c;
  }
}
