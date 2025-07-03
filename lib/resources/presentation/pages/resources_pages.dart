import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/go_back_button.dart';
import 'package:icheja_mobile/common/presentation/widgets/grid_container.dart';
import 'package:icheja_mobile/core/application/dependency_injection.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resources_viewmodel.dart';
import 'package:icheja_mobile/resources/presentation/widgets/resource_navigation.dart';
import 'package:provider/provider.dart';

class ResourcesPages extends StatelessWidget {
  const ResourcesPages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => sl<ResourcesViewmodel>(),
      child: AppLayout(
          body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Consumer<ResourcesViewmodel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return const HomeSkeleton();
            }

            if (viewModel.error != null) {
              return Center(child: Text('Error: ${viewModel.error}'));
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                WelcomeHeader(name: viewModel.username ?? 'Usuario'),
                const SizedBox(height: 25),
                // ? This is the header for the resources page
                const Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: GoBackButton(route: AppRoutesConstant.home)),
                    ),
                    SizedBox(width: 11),
                    Expanded(
                      flex: 5,
                      child: Text(
                        'Elige que quieres practicar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // ? This is the list of resources
                viewModel.resources.isEmpty
                    ? const Center(
                        child: Text(
                          'No hay recursos disponibles',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    : GridContainer<ResourcesEntity>(
                        gridColumns: 2,
                        gridVerticalPadding: 13,
                        gridHorizontalPadding: 10,
                        aspectRatioItem: 1.0,
                        items: viewModel.resources,
                        itemContent: (item, index, extraData) {
                          return ResourceNavigation(
                            itemResource: item,
                            cardColor: index == 0
                                ? ColorTheme.tertiary
                                : ColorTheme.secondary,
                          );
                        })
              ],
            );
          },
        ),
      )),
    );
  }
}
