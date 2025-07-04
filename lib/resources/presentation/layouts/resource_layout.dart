import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/go_back_button.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/home/presentation/widgets/home_skeleton.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resource_detail_viewmodel.dart';

class ResourceLayout extends StatelessWidget {
  final String fieldNameSelected;
  final ResourceDetailViewmodel viewmodel;
  final List<Widget> childrens;
  const ResourceLayout(
      {super.key,
      required this.childrens,
      required this.viewmodel,
      required this.fieldNameSelected});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AppLayout(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (viewmodel.isLoading) ...[
              const HomeSkeleton(),
            ] else if (viewmodel.error.isNotEmpty) ...[
              Center(child: Text('Error: ${viewmodel.error}')),
            ] else ...[
              WelcomeHeader(name: viewmodel.username ?? 'Usuario'),
              const SizedBox(height: 17),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Center(
                        child: GoBackButton(
                            route:
                                '${AppRoutesConstant.resources}/$fieldNameSelected')),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Recursos',
                      style: TextStyle(
                        fontSize: size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Text(
                      textAlign: TextAlign.end,
                      viewmodel.resourceDetail.title,
                      style: TextStyle(
                          fontSize: size.width * 0.07,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.tertiary),
                    ), // Placeholder for alignment
                  ),
                ],
              ),
              const SizedBox(height: 17),
              ...childrens
            ]
          ],
        ),
      ),
    );
  }
}
