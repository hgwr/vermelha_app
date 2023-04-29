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

  Future<void> addCharacter(Character character) async {
    _characters.add(character);
    await _characterRepository.save(character);
    notifyListeners();
  }

  Future<void> removeCharacter(Character character) async {
    _characters.remove(character);
    await _characterRepository.delete(character);
    notifyListeners();
  }

  Future<void> updateCharacter(Character character) async {
    final index = _characters.indexWhere((c) => c.id == character.id);
    _characters[index] = character;
    await _characterRepository.update(character);
    notifyListeners();
  }
}
