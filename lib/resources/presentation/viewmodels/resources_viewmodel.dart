import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/domain/constants/ui_constants.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/resources/data/datasources/get_resources_and_exercises_data_source.dart';
import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';

class ResourcesViewmodel extends ChangeNotifier {
  final GetResourcesAndExercisesDataSource _getResourcesAndExercisesDataSource =
      GetResourcesAndExercisesDataSource();
  final SessionManager _sessionManager;

  String? _username;
  String? get username => _username;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  List<ResourcesEntity> _resources = [];

  List<ResourcesEntity> get resources => _resources;

  ResourcesViewmodel(this._sessionManager) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      _isLoading = true;
      notifyListeners();
      await Future.delayed(const Duration(seconds: 1));
      await _fetchUsername();
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

  Future<void> fetchResources(String field) async {
    try {
      if (field == UIConstants.all_resources) {
        _resources =
            await _getResourcesAndExercisesDataSource.getAllResources();
      } else {
        _resources = await _getResourcesAndExercisesDataSource
            .getResourcesAndExercisesByField(field);
      }
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
