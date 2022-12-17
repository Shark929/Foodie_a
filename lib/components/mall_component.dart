import 'package:flutter/material.dart';

class MallComponent extends StatelessWidget {
  final String image, mallName;
  const MallComponent({
    super.key,
    required this.image,
    required this.mallName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(children: [
        Container(
          width: 100,
          height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                  image: NetworkImage(image), fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mallName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        )
      ]),
    );
  }
}
