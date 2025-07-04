import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/layouts/modal_layout.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_content.dart';
import 'package:icheja_mobile/common/presentation/widgets/modal_footer_actions.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_container_border.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/common/presentation/widgets/grid_container.dart';
import 'package:icheja_mobile/resources/domain/entities/abecedary_resource_entity.dart';

class AbecedaryContent extends StatelessWidget {
  final List<AbecedaryResourceEntity> content;
  const AbecedaryContent({super.key, required this.content});

  void _showLetterModal(BuildContext context, AbecedaryResourceEntity item) {
    ModalLayout.show(
      context: context,
      content: ModalContent(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${item.vocal}${item.minusVocal}',
              style: const TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 20),
            CustomSvgNetworkImage(
              imageUrl: item.imageUrl,
              width: 200,
              height: 150,
              errorImage: const Icon(Icons.error, size: 100.0),
            ),
          ],
        ),
      ),
      footerActions: ModalFooterActions(
        buttonTypes: const [ModalButtonType.close],
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GridContainer(
        gridVerticalPadding: 6.0,
        aspectRatioItem: 2.0,
        items: content,
        itemContent: (item, index, extraData) {
          return GestureDetector(
            onTap: () => _showLetterModal(context, item),
            child: CustomContainerBorder(
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
            )),
          );
        });
  }
}
