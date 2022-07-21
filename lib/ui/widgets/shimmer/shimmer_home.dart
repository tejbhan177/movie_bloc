import 'package:flutter/material.dart';
import 'package:movie_bloc/ui/widgets/shimmer/shimmer.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: ListView(
        children: [
          SizedBox(
            height: size.height * 0.15,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.2, right: size.width * 0.2),
            child: shimmer(
              size: size,
              height: size.height * 0.15,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: size.width * 0.1, right: size.width * 0.1),
            child: shimmer(
              size: size,
              width: size.width * 0.8,
              height: 20.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              shimmer(
                size: size,
                width: size.width * 0.2,
                height: 40.0,
              ),
              shimmer(
                size: size,
                width: size.width * 0.2,
                height: 40.0,
              ),
              shimmer(
                size: size,
                width: size.width * 0.2,
                height: 40.0,
              ),
            ],
          ),
          const SizedBox(
            height: 20.0,
          ),
          GridView.builder(
              itemCount: 9,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 2 / 3),
              itemBuilder: (BuildContext context, int index) {
                return shimmer(
                  size: size,
                  width: size.width * 0.2,
                  height: 40.0,
                );
              })
        ],
      ),
    );
  }
}
