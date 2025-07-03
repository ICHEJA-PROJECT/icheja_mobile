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
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'B',
              minusVocal: 'b',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'C',
              minusVocal: 'c',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'D',
              minusVocal: 'd',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'E',
              minusVocal: 'e',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'F',
              minusVocal: 'f',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'G',
              minusVocal: 'g',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'H',
              minusVocal: 'h',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'I',
              minusVocal: 'i',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'J',
              minusVocal: 'j',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'K',
              minusVocal: 'k',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'L',
              minusVocal: 'l',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'M',
              minusVocal: 'm',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'N',
              minusVocal: 'n',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'Ñ',
              minusVocal: 'ñ',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'O',
              minusVocal: 'o',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'P',
              minusVocal: 'p',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'Q',
              minusVocal: 'q',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'R',
              minusVocal: 'r',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'S',
              minusVocal: 's',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'T',
              minusVocal: 't',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'U',
              minusVocal: 'u',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'V',
              minusVocal: 'v',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'W',
              minusVocal: 'w',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'X',
              minusVocal: 'x',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'Y',
              minusVocal: 'y',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
          AbecedaryResourceEntity(
              vocal: 'Z',
              minusVocal: 'z',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/15385/15385302.png'),
        ],
      );
    } catch (e) {
      _error = 'Failed to load resources: $e';
    }
  }
}
