import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projetpfe/constants/sizes.dart';

class LikeIcon extends StatefulWidget {
  final double? width, height, size;
  final IconData icon;
  final Color? color;
  final Color? backgroundColor;
  final String annonceId;

  const LikeIcon({
    Key? key,
    this.width,
    this.height,
    this.size = HSize.lg,
    required this.icon,
    this.color,
    this.backgroundColor,
    required this.annonceId,
  }) : super(key: key);

  @override
  _LikeIconState createState() => _LikeIconState();
}

class _LikeIconState extends State<LikeIcon> {
  bool isInWishlist = false;

  @override
  void initState() {
    super.initState();
    _checkIfInWishlist();
  }

  Future<void> _checkIfInWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final wishlistDoc = await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .get();

    setState(() {
      isInWishlist = wishlistDoc.exists;
    });
  }

  Future<void> _addToWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .set({
      'addedAt': FieldValue.serverTimestamp(),
    });

    setState(() {
      isInWishlist = true;
    });
  }

  Future<void> _removeFromWishlist() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('wishlists')
        .doc(userId)
        .collection('items')
        .doc(widget.annonceId)
        .delete();

    setState(() {
      isInWishlist = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(widget.icon, size: widget.size, color: isInWishlist ? Colors.red : widget.color),
        onPressed: () {
          if (isInWishlist) {
            _removeFromWishlist();
          } else {
            _addToWishlist();
          }
        },
      ),
    );
  }
}
