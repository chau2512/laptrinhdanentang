class CalculatorBrain {
  CalculatorBrain({required this.height, required this.weight});

  final int height;
  final int weight;

  double _bmi = 0;

  String calculateBMI() {
    _bmi = weight / ((height / 100) * (height / 100));
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return 'THỪA CÂN';
    } else if (_bmi > 18.5) {
      return 'BÌNH THƯỜNG';
    } else {
      return 'THIẾU CÂN';
    }
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return 'Bạn có cân nặng cao hơn bình thường. Hãy cố gắng tập thể dục nhiều hơn nhé!';
    } else if (_bmi > 18.5) {
      return 'Bạn có cân nặng hoàn toàn bình thường. Làm tốt lắm!';
    } else {
      return 'Bạn có cân nặng thấp hơn bình thường. Bạn nên ăn uống nhiều hơn nhé!';
    }
  }
}
