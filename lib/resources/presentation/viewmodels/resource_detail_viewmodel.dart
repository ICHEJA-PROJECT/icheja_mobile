import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/session/session_manager.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';
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
        id: '1',
        title: 'Abecedario',
        content: <AbecedaryResourceEntity>[
          AbecedaryResourceEntity(
              vocal: 'A',
              minusVocal: 'a',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'B',
              minusVocal: 'b',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'C',
              minusVocal: 'c',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'D',
              minusVocal: 'd',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'E',
              minusVocal: 'e',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'F',
              minusVocal: 'f',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'G',
              minusVocal: 'g',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'H',
              minusVocal: 'h',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'I',
              minusVocal: 'i',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'J',
              minusVocal: 'j',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'K',
              minusVocal: 'k',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'L',
              minusVocal: 'l',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'M',
              minusVocal: 'm',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'N',
              minusVocal: 'n',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'Ñ',
              minusVocal: 'ñ',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'O',
              minusVocal: 'o',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'P',
              minusVocal: 'p',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'Q',
              minusVocal: 'q',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'R',
              minusVocal: 'r',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'S',
              minusVocal: 's',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'T',
              minusVocal: 't',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'U',
              minusVocal: 'u',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'V',
              minusVocal: 'v',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'W',
              minusVocal: 'w',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'X',
              minusVocal: 'x',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'Y',
              minusVocal: 'y',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
          AbecedaryResourceEntity(
              vocal: 'Z',
              minusVocal: 'z',
              imageUrl:
                  'https://res.cloudinary.com/dsiamqhuu/image/upload/v1751572924/ICHEJA/ICHEJA/T2_R1_1.svg'),
        ],
      );
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
