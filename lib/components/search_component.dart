import 'package:flutter/material.dart';

class SearchComponent extends StatelessWidget {
  final String image, title;
  const SearchComponent({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    image != ""
                        ? image
                        : "https://i.picsum.photos/id/57/2448/3264.jpg?hmac=ewraXYesC6HuSEAJsg3Q80bXd1GyJTxekI05Xt9YjfQ",
                  ),
                  fit: BoxFit.fill),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
