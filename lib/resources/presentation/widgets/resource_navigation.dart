import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/image_decoration_container.dart';
import 'package:icheja_mobile/resources/domain/entities/resources_entity.dart';

class ResourceNavigation extends StatelessWidget {
  final ResourcesEntity itemResource;
  final Color cardColor;
  const ResourceNavigation(
      {super.key,
      required this.itemResource,
      this.cardColor = ColorTheme.secondary});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(itemResource.routeToGo);
      },
      child: Card(
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.only(
              top: 8.0, left: 15.0, right: 15.0, bottom: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageDecorationContainer(
                imageUrl: itemResource.imageUrl,
                height: 100,
                borderRadius: 10.0,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Center(
                  child: Text(
                    itemResource.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
