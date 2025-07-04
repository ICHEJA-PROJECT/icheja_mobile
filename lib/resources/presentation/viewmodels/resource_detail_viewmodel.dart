import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/resources/data/datasources/get_resource_detail_data_source.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';
import 'package:icheja_mobile/resources/domain/entities/resource_detail_entity.dart';

class ResourceDetailViewmodel extends ChangeNotifier {
  final GetResourceDetailDataSource _getResourceDetailDataSource =
      GetResourceDetailDataSource();
  final SessionManager _sessionManager;

  String? _username;
  String? get username => _username;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  late ResourceDetailEntity _resourceDetail;

  ResourceDetailEntity get resourceDetail => _resourceDetail;

  ResourceDetailViewmodel(this._sessionManager) {
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

  Future<void> fetchResource(title, field) async {
    try {
      _resourceDetail = await _getResourceDetailDataSource.getResourceDetail(
        title: title,
        field: field,
      );
      print(_resourceDetail.content.runtimeType);
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
