import 'package:flutter/material.dart';
import 'package:icheja_mobile/home/domain/entities/progress_entity.dart';
import 'package:icheja_mobile/home/domain/usecases/get_progress.dart';

class HomeViewModel extends ChangeNotifier {
  final GetProgressUseCase _getProgressUseCase;

  HomeViewModel(this._getProgressUseCase) {
    fetchProgress();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<ProgressEntity> _progressList = [];
  List<ProgressEntity> get progressList => _progressList;

  String? _error;
  String? get error => _error;

  Future<void> fetchProgress() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _progressList = await _getProgressUseCase();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
