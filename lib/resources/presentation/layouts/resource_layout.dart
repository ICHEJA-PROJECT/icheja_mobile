import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/app_layout.dart';
import 'package:icheja_mobile/common/presentation/widgets/go_back_button.dart';
import 'package:icheja_mobile/core/router/domain/constants/app_routes_constant.dart';
import 'package:icheja_mobile/home/presentation/widgets/welcome_header.dart';
import 'package:icheja_mobile/resources/presentation/viewmodels/resource_detail_viewmodel.dart';

class ResourceLayout extends StatelessWidget {
  final ResourceDetailViewmodel viewmodel;
  final List<Widget> childrens;
  const ResourceLayout(
      {super.key, required this.childrens, required this.viewmodel});

  @override
  Widget build(BuildContext context) {
    return AppLayout(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WelcomeHeader(name: viewmodel.username ?? 'Usuario'),
            const SizedBox(height: 25),
            // ? This is the header for the resources layout
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                      child: GoBackButton(route: AppRoutesConstant.resources)),
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
            ...childrens
          ],
        ),
      ),
    );
  }
}
