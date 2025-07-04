import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/theme/color_theme.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/exercises/domain/entities/memorama_entity.dart';

class MemoramaCardWidget extends StatelessWidget {
  final MemoramaCard card;
  final VoidCallback onTap;

  const MemoramaCardWidget({
    super.key,
    required this.card,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: card.isMatched ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: card.isMatched 
                ? ColorTheme.greenColor 
                : ColorTheme.secondary,
            width: 3,
          ),
          color: card.isFlipped || card.isMatched 
              ? Colors.white 
              : ColorTheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: _buildCardContent(),
      ),
    );
  }

  Widget _buildCardContent() {
    if (!card.isFlipped && !card.isMatched) {
      // Carta volteada - mostrar dorso
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorTheme.primary,
              ColorTheme.primary.withOpacity(0.8),
            ],
          ),
        ),
        child: const Center(
          child: Icon(
            Icons.quiz,
            size: 32,
            color: Colors.white,
          ),
        ),
      );
    }

    // Carta destapada - mostrar contenido
    if (card.type == MemoramaCardType.letter) {
      return Center(
        child: Text(
          card.content,
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: card.isMatched ? ColorTheme.greenColor : ColorTheme.primary,
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomSvgNetworkImage(
          imageUrl: card.content,
          width: double.infinity,
          height: double.infinity,
          errorImage: const Icon(
            Icons.error,
            size: 30,
            color: Colors.red,
          ),
        ),
      );
    }
  }
}
