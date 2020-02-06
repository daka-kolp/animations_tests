import 'package:flutter/cupertino.dart';
import 'package:ram_app/src/data/repos/rick_ang_morty_repo.dart';
import 'package:ram_app/src/domain/entities/character.dart';

class MainPageChangeNotifier with ChangeNotifier {
  final _repo = RaMRepo();
  static int page = 0;

  List<Character> _characters = [];
  bool _isLoading = false;

  List<Character> get characters => _characters;

  bool get isLoading => _isLoading;

  MainPageChangeNotifier() {
    _update();
  }

  Future<void> _update() async {
    _isLoading = true;
    notifyListeners();
    try {
      _characters.addAll(await _repo.getCharacters(page));
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCharacters() async {
    page++;
    print(page);
    await _update();
  }
}
