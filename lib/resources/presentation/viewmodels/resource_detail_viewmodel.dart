import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/resources/domain/entities/family_resource_entity.dart';
import 'package:icheja_mobile/resources/domain/entities/resource_detail_entity.dart';

class ResourceDetailViewmodel extends ChangeNotifier {
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
      _resourceDetail = ResourceDetailEntity(
          id: "1",
          title: "Familia",
          content: <FamilyResourceEntity>[
            FamilyResourceEntity(
                role: "Mamá",
                imgPath:
                    "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751579595/ICHEJA/ICHEJA/T3_R1_1"),
            FamilyResourceEntity(
                role: "Papá",
                imgPath:
                    "http://res.cloudinary.com/dsiamqhuu/image/upload/v1751579627/ICHEJA/ICHEJA/T3_R1_2"),
            FamilyResourceEntity(
                role: "Hermano",
                imgPath:
                    "http://res.cloudinary.com/dsiamqhuu/raw/upload/v1751581189/ICHEJA/ICHEJA/T3_R1_3"),
            FamilyResourceEntity(
                role: "Hermana",
                imgPath:
                    "http://res.cloudinary.com/dsiamqhuu/raw/upload/v1751581248/ICHEJA/ICHEJA/T3_R1_4"),
          ]);
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
