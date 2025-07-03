import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';

class ResourcesViewmodel extends ChangeNotifier {
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
      await _fetchResources();
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

  Future<void> _fetchResources() async {
    try {
      _resources = [
        ResourcesEntity(
          id: '1',
          title: 'Teoría',
          imageUrl:
              'https://previews.123rf.com/images/matriyoshka/matriyoshka1510/matriyoshka151000021/46276042-science-and-international-education-classroom-university-professor-theory-teacher-college-lecture.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '2',
          title: 'Ejercicio 1',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '3',
          title:
              'Ejercicio 2',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '4',
          title: 'Ejercicio 3',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '5',
          title: 'Ejercicio 4',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '6',
          title: 'Ejercicio 5',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
        ResourcesEntity(
          id: '7',
          title: 'Ejercicio 6',
          imageUrl:
              'https://img.freepik.com/premium-vector/little-boy-doing-homework-by-read-writing-his-desk-vector-illustration_181870-188.jpg',
          routeToGo: AppRoutesConstant.home,
        ),
      ];
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
