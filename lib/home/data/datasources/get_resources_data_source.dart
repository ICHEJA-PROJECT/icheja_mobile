import 'dart:async';

import 'package:icheja_mobile/core/data/datasource/mock/mock_data.dart';
import 'package:icheja_mobile/home/domain/entities/resource.dart';
import 'package:icheja_mobile/home/domain/repositories/get_resources_repository.dart';

class GetResourcesDataSource implements GetResourcesRepository {
  @override
  Future<List<Resource>> getResources() async {
    final res = content
        .map((e) => Resource(name: e["Tema"], imageUrl: e["image"]))
        .toList();
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    print(res);
    // Return the list of resources
    if (res.isEmpty) {
      throw Exception("No resources found");
    }
    return res;
  }
}
