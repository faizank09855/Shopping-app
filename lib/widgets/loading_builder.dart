import 'package:flutter/material.dart';
import 'package:transparent/home_module/widgets/widgets.dart';

abstract class LoadingBuilderWidgets {
  Widget listLoading();

  Widget cardLoading();

  Widget verticalCardLoading();

  Widget circleLoading();
}

class LoadingBuilder extends LoadingBuilderWidgets {
  @override
  Widget cardLoading() {
    // TODO: implement cardLoading
    return SizedBox();
  }

  @override
  Widget listLoading() {
    return ListView.builder(
      padding: const EdgeInsets.only(left: 16),
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          width: 110,
          margin: const EdgeInsets.only(top: 16, bottom: 16, right: 16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }

  @override
  Widget verticalCardLoading() {
    return SizedBox();
  }

  @override
  Widget circleLoading() {
    return ListView.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey.shade400,
          ),
        );
      },
    );
  }
}
