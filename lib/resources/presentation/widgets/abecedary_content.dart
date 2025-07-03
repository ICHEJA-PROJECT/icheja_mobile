import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_container_border.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/grid_container.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';

class AbecedaryContent extends StatelessWidget {
  final List<AbecedaryResourceEntity> content;
  const AbecedaryContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridContainer(
        gridVerticalPadding: 6.0,
        aspectRatioItem: 2.0,
        items: content,
        itemContent: (item, index, extraData) {
          return CustomContainerBorder(
              item: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${item.vocal}${item.minusVocal}',
                style: const TextStyle(
                    fontSize: 65,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFFDD4242)),
              ),
              CustomSvgNetworkImage(
                imageUrl: item.imageUrl,
                width: size.width * 0.15,
                height: size.height * 0.1,
                errorImage: const Icon(Icons.error, size: 50.0),
              )
            ],
          ));
        });
  }
}
