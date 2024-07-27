// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/core/themes/app_styles.dart';

class DoublePropertyWidget extends StatelessWidget {
  const DoublePropertyWidget({
    super.key,
    required this.svg1,
    required this.svg2,
    required this.name1,
    required this.name2,
    required this.value1,
    required this.value2,
  });
  final String svg1, svg2;
  final String name1, name2;
  final String value1, value2;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 25),
          decoration: BoxDecoration(
            color: const Color(0xC919346B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(children: [
                  SvgPicture.asset(
                    'assets/svg/$svg1',
                    width: 40,
                    height: 40,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    name1,
                    style: AppStyles.bodyBoldM,
                  ),
                  Text(
                    value1,
                    style: const TextStyle(color: Color(0xFFBCBCBC)),
                  ),
                ]),
                const SizedBox(width: 10),
                Column(children: [
                  SvgPicture.asset(
                    'assets/svg/$svg2',
                    width: 40,
                    height: 40,
                    allowDrawingOutsideViewBox: true,
                  ),
                  Text(
                    name2,
                    style: AppStyles.bodyBoldM,
                  ),
                  Text(
                    value2,
                    style: const TextStyle(color: Color(0xFFBCBCBC)),
                  ),
                ]),
              ],
            ),
          )),
    );
  }
}
