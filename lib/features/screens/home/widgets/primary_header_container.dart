import 'package:flutter/material.dart';
import 'package:projetpfe/features/screens/home/widgets/circular_container.dart';
import 'package:projetpfe/features/screens/home/widgets/curved_edges_widget.dart';
import 'package:projetpfe/themes/theme.dart';

class HPrimaryHeaderContainer extends StatelessWidget {
  const HPrimaryHeaderContainer({
    super.key, required this.child,
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return HCurvedEdgeWidget(
      child:  Container(
        color:lightColorScheme.secondary,

            child: Stack(
              children: [
                Positioned(top: -150,right: -250,child: HCircularContainer(backgroundColor: Colors.white.withOpacity(0.1),)),
                Positioned(top: 100,right: -300,child: HCircularContainer(backgroundColor: Colors.white.withOpacity(0.1),)),
                child,
              ],
          ),
      ),
    );
  }
}