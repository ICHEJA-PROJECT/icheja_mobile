import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';

class ResourceDetailViewmodel extends ChangeNotifier {
  final SessionManager _sessionManager;

  String? _username;
  String? get username => _username;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  dynamic _resourceDetail;

  dynamic get resourceDetail => _resourceDetail;

  ResourceDetailViewmodel(this._sessionManager) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      await _fetchUsername();
      await _fetchResource();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchUsername() async {
    try {
      _username = await _sessionManager.getUserName();
    } catch (e) {
      _error = 'Failed to load username: $e';
    }
  }

  Future<void> _fetchResource() async {
    try {
      _resourceDetail = {
        'id': '1',
        'title': 'Abecedario',
        'imageUrl':
            'https://previews.123rf.com/images/matriyoshka/matriyoshka1510/matriyoshka151000021/46276042-science-and-international-education-classroom-university-professor-theory-teacher-college-lecture.jpg',
        'content': 'Detailed content about the theory resource goes here.'
      };
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
