import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';




class NewSlide extends StatefulWidget {
  const NewSlide({Key? key}) : super(key: key);

  @override
  State<NewSlide> createState() => _NewSlideState();
}

class _NewSlideState extends State<NewSlide> {

  late SfRangeValues _values;
 late double _numberFormat;
  late TextEditingController _rangeStartController;
  late TextEditingController _rangeEndController;

  Widget _buildThumbIcon(TextEditingController controller) {
    return Transform.translate(
      // Here 20 is thumb diameter and 5 is spacing between thumb and text.
      offset: const Offset(0, 25),
      child: OverflowBox(
        maxWidth: 150,
        child: TextField(
          textAlign: TextAlign.center,
          decoration:
          const InputDecoration(border: InputBorder.none, isDense: true),
          controller: controller,
        ),
      ),
    );
  }

  String _getFormattedText(dynamic value) {
    return 'asdf';
  }

  @override
  void initState() {
    _values = const SfRangeValues(3.0, 7.0);
    _rangeStartController = TextEditingController();
    _rangeEndController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _rangeStartController.dispose();
    _rangeEndController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfRangeSlider(
        min: 0.0,
        max: 10.0,
        startThumbIcon: _buildThumbIcon(_rangeStartController),
        endThumbIcon: _buildThumbIcon(_rangeEndController),
        values: _values,
        onChangeStart: (SfRangeValues newValues) {
          _rangeStartController.text = _getFormattedText(newValues.start);
          _rangeEndController.text = _getFormattedText(newValues.end);
        },
        onChanged: (SfRangeValues newValues) {
          setState(() {
            _rangeStartController.text = _getFormattedText(newValues.start);
            _rangeEndController.text = _getFormattedText(newValues.end);
            _values = newValues;
          });
        },
        onChangeEnd: (SfRangeValues newValues) {
          _rangeStartController.text = "";
          _rangeEndController.text = "";
        },
      ),
    );
  }

}

class WaveSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => WaveSliderState();
}

class WaveSliderState extends State<WaveSlider> {

  double _value = 0;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _slider(200, 200),
      ),
    );
  }

  double percentage = 0.1;
  Widget _slider(double width, double height) {
    return GestureDetector(
      onVerticalDragStart: (details) {
        percentage = (height - details.localPosition.dy) / height;
        setState(() {});
      },
      onVerticalDragUpdate: (details) {
        percentage = (height - details.localPosition.dy) / height;
        setState(() {});
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width / 2),
          color: Colors.blueGrey,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width / 2),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [
                0.0,
                1 - percentage,
                1 - percentage,
                1.0,
              ],
              colors: const [
                Colors.transparent,
                Colors.transparent,
                Colors.blue,
                Colors.blue,
              ],
            ),
          ),
        ),
      ),
    );
  }

}



class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}