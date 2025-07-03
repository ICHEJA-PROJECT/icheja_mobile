import 'package:flutter/material.dart';
import '../widgets/modal_header.dart';
import '../widgets/modal_content.dart';
import '../widgets/modal_footer_actions.dart';

// Solo header --
// ModalLayout(header: ModalHeader(title: "Hola"))

// Solo contenido --
// ModalLayout(content: ModalContent(child: Text("Contenido")))

// Solo botones --
// ModalLayout(footerActions: ModalFooterActions(buttonTypes: [ModalButtonType.close]))

// Combinación completa -- 
// ModalLayout(
  // header: ModalHeader(title*: "Título", titleColor: Colors.red, subtitle: "Subtítulo"),
  // content: ModalContent(child*: Image.asset("imagen.png"), padding: EdgeInsets.all(16)),
  // footerActions: ModalFooterActions(
  //   buttonTypes: [ModalButtonType.close, ModalButtonType.next],
  //   onClose: () => Navigator.pop(context),
  //   onNext: () => print("Siguiente"),
  // ),
// )

class ModalLayout extends StatelessWidget {
  final ModalHeader? header;
  final ModalContent? content;
  final ModalFooterActions? footerActions;
  final Widget? child;
  
  const ModalLayout({
    super.key,
    this.header,
    this.content,
    this.footerActions,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (header != null) header!,
          if (content != null) content!,
          if (child != null) child!,
          if (footerActions != null) footerActions!,
        ],
      ),
    );
  }
}

