import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/resources/presentation/layouts/resource_layout.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resource_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class ResourceDetail extends StatelessWidget {
  const ResourceDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<ResourceDetailViewmodel>(),
      child: Consumer<ResourceDetailViewmodel>(
        builder: (context, viewModel, child) {
          return ResourceLayout(
            viewmodel: viewModel,
            childrens: [Text('Hola')],
          );
        },
      ),
    );
  }
}
