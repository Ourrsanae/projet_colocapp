import 'package:flutter/material.dart';
import 'package:projetpfe/features/screens/home/widgets/cureved_edges.dart';


class HCurvedEdgeWidget extends StatelessWidget {
  const HCurvedEdgeWidget({
    super.key, this.child,
  });
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HCustomCurvedEdges(),
      child: child,
    );
  }
}