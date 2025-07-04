import 'package:flutter/material.dart';
import 'package:icheja_mobile/common/presentation/widgets/custom_svg_network_image.dart';
import 'package:icheja_mobile/resources/domain/entities/family_resource_entity.dart';

class FamilyContet extends StatefulWidget {
  final List<FamilyResourceEntity> contet;
  const FamilyContet({super.key, required this.contet});

  @override
  State<FamilyContet> createState() => _FamilyContetState();
}

class _FamilyContetState extends State<FamilyContet> {
  PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.8);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contet.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemCount: widget.contet.length,
            itemBuilder: (context, index) {
              final resource = widget.contet[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildFamilyCard(resource),
              );
            },
          ),
          // Botón anterior
          if (widget.contet.length > 1)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.chevron_left,
                      size: 30,
                      color: _currentIndex > 0 ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          // Botón siguiente
          if (widget.contet.length > 1)
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex < widget.contet.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.chevron_right,
                      size: 30,
                      color: _currentIndex < widget.contet.length - 1
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFamilyCard(FamilyResourceEntity resource) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF357ABD),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Título del rol
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              resource.role,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          // Imagen del personaje
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomSvgNetworkImage(
                imageUrl: resource.imgPath,
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.5,
                errorImage: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
