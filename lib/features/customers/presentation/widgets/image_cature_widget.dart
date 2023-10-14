import 'package:flutter/material.dart';
import 'package:searchino/core/app_theme.dart';

class ImageCaptureWidget extends StatelessWidget {
  final void Function() onGallery;
  final void Function() onCamera;
  const ImageCaptureWidget(
      {super.key, required this.onGallery, required this.onCamera});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Container(
        margin: const EdgeInsets.all(20),
        height: 200,
        // width: MediaQuery.of(context).size.width-200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please Choose Image",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: onGallery,
              child: Row(
                children: [
                  const Icon(
                    Icons.browse_gallery,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text(
                        "From Gallery",
                        style: TextStyle(fontSize: 20),
                      )),
                ],
              ),
            ),
            InkWell(
              onTap: onCamera,
              child: Row(
                children: [
                  const Icon(
                    Icons.camera,
                    size: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text("From Camera",
                          style: TextStyle(fontSize: 20))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
