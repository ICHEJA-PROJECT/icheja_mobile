import 'package:flutter/material.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';
import 'package:icheja_mobile/resources/domain/entities/family_resource_entity.dart';
import 'package:icheja_mobile/resources/presentation/layouts/resource_layout.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resource_detail_viewmodel.dart';
import 'package:icheja_mobile/resources/presentation/widgets/abecedary_content.dart';
import 'package:icheja_mobile/resources/presentation/widgets/family_content.dart';
import 'package:provider/provider.dart';

class ResourceDetail extends StatelessWidget {
  final String detailTitle;
  final String fieldNameSelected;
  const ResourceDetail(
      {super.key, required this.fieldNameSelected, required this.detailTitle});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final viewModel = sl<ResourceDetailViewmodel>();
        viewModel.fetchResource(detailTitle, fieldNameSelected);
        return viewModel;
      },
      child: Consumer<ResourceDetailViewmodel>(
        builder: (context, viewModel, child) {
          return ResourceLayout(
            fieldNameSelected: fieldNameSelected,
            viewmodel: viewModel,
            childrens: [
              if (!viewModel.isLoading && viewModel.error.isEmpty) ...[
                // Check for abecedary content
                if (viewModel.resourceDetail.content
                    is List<AbecedaryResourceEntity>) ...[
                  AbecedaryContent(
                    content: viewModel.resourceDetail.content
                        as List<AbecedaryResourceEntity>,
                  )
                ] else if (viewModel.resourceDetail.content
                    is List<FamilyResourceEntity>) ...[
                  FamilyContet(
                      contet: viewModel.resourceDetail.content
                          as List<FamilyResourceEntity>)
                ]
              ]
            ],
          );
        },
      ),
    );
  }
}
