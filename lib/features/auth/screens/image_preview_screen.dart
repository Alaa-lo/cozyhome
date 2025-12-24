import 'dart:io';
import 'package:flutter/material.dart';

class ImagePreviewScreen extends StatefulWidget {
  final File imageFile;
  final VoidCallback onDelete;
  final VoidCallback onReplace;

  const ImagePreviewScreen({
    Key? key,
    required this.imageFile,
    required this.onDelete,
    required this.onReplace,
  }) : super(key: key);

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen>
    with SingleTickerProviderStateMixin {
  double opacity = 0;
  double scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        opacity = 1;
        scale = 1;
      });
    });
  }

  void animateDelete() {
    setState(() {
      opacity = 0;
      scale = 0.7;
    });

    Future.delayed(const Duration(milliseconds: 250), () {
      widget.onDelete();
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: opacity,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 250),
                scale: scale,
                child: Image.file(widget.imageFile),
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEBEADA),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Delete Image?",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF234E36),
                              ),
                            ),
                            const SizedBox(height: 15),
                            const Text(
                              "Are you sure you want to delete this image?",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF375534),
                              ),
                            ),
                            const SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF375534),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF234E36),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    animateDelete();
                                  },
                                  child: const Text(
                                    "Yes",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.delete_outline,
                color: Colors.red,
                size: 32,
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 20,
            child: GestureDetector(
              onTap: () {
                widget.onReplace();
                Navigator.pop(context);
              },
              child: const Icon(Icons.refresh, color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}
