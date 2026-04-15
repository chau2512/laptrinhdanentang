import 'story.dart';

class StoryBrain {
  int _storyNumber = 0;

  final List<Story> _storyData = [
    Story(
        storyTitle:
            'Bạn tỉnh dậy trong một con tàu vũ trụ trôi dạt. Hệ thống cảnh báo oxy đang cạn kiệt. Bạn nhận thấy hai lối đi: Một hành lang tối sáng lập lòe và một buồng máy đang bốc khói.',
        choice1: 'Khám phá hành lang tối.',
        choice2: 'Lao vào buồng máy kiểm tra.'), // 0
    Story(
        storyTitle:
            'Hành lang tối dẫn bạn đến phòng điều khiển chính. Tuy nhiên, hệ thống yêu cầu mã số để khôi phục oxy hoặc bạn có thể thử phá hủy nó.',
        choice1: 'Hack hệ thống bằng kỹ năng của bạn.',
        choice2: 'Đập nát bảng điều khiển.'), // 1
    Story(
        storyTitle:
            'Trong buồng máy, bạn phát hiện một lỗ hổng rò rỉ khí. Kế bên là một bình keo vá chuyên dụng và một bộ trang phục du hành.',
        choice1: 'Dùng ống keo vá ngay lập tức.',
        choice2: 'Mặc bộ đồ du hành phòng hờ trước.'), // 2
    Story(
        storyTitle:
            'Bạn hack hệ thống thành công! Oxy được khôi phục, liên lạc được thiết lập. Đội cứu hộ đang trên đường tới! Bạn đã chiến thắng!',
        choice1: 'Khởi động lại',
        choice2: ''), // 3
    Story(
        storyTitle:
            'Việc đập nát khiến hệ thống điện chập mạch, khóa kín các lối ra. Cạn oxy, bạn mãi không rời được con tàu này. Trò chơi kết thúc!',
        choice1: 'Khởi động lại',
        choice2: ''), // 4
    Story(
        storyTitle:
            'Bình keo giúp vá lỗ hổng, nhưng do bạn không dùng đồ bảo hộ, tia phóng xạ từ động cơ đã cướp đi sinh mạng của bạn. Trò chơi kết thúc!',
        choice1: 'Khởi động lại',
        choice2: ''), // 5
    Story(
        storyTitle:
            'Mặc đồ du hành cẩn thận giúp bạn cách ly an toàn. Cùng với bình keo, bạn vá xong lỗ hổng và khôi phục áp suất tàu. Bạn tìm được một tàu con và thoát ra. Mọi chuyển ổn rồi!',
        choice1: 'Khởi động lại',
        choice2: ''), // 6
  ];

  String getStory() {
    return _storyData[_storyNumber].storyTitle;
  }

  String getChoice1() {
    return _storyData[_storyNumber].choice1;
  }

  String getChoice2() {
    return _storyData[_storyNumber].choice2;
  }

  void nextStory(int choiceNumber) {
    if (choiceNumber == 1 && _storyNumber == 0) {
      _storyNumber = 1;
    } else if (choiceNumber == 2 && _storyNumber == 0) {
      _storyNumber = 2;
    } else if (choiceNumber == 1 && _storyNumber == 1) {
      _storyNumber = 3;
    } else if (choiceNumber == 2 && _storyNumber == 1) {
      _storyNumber = 4;
    } else if (choiceNumber == 1 && _storyNumber == 2) {
      _storyNumber = 5;
    } else if (choiceNumber == 2 && _storyNumber == 2) {
      _storyNumber = 6;
    } else if (_storyNumber == 3 || _storyNumber == 4 || _storyNumber == 5 ||
        _storyNumber == 6) {
      restart();
    }
  }

  void restart() {
    _storyNumber = 0;
  }

  bool buttonShouldBeVisible() {
    if (_storyNumber == 0 || _storyNumber == 1 || _storyNumber == 2) {
      return true;
    } else {
      return false;
    }
  }
}
