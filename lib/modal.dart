import 'package:flutter/material.dart';
import 'profile_input.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({super.key});

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  int _selectedTab = 0;
  List<bool> tabCompleted = [false, false, false];

  Future<void> _openProfileInputPage(int tabIndex) async {
    final result = await Navigator.of(context).push<int>(
      MaterialPageRoute(builder: (_) => ProfileInputPage(initialTab: tabIndex)),
    );
    if (result != null) {
      setState(() {
        tabCompleted[result] = true;
        _selectedTab = result;
      });
    }
  }

  void _handleCompleteButton(int tabIndex) {
    if (tabIndex < 2) {
      setState(() {
        _selectedTab = tabIndex + 1;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabTexts = ['이것은 탭1 모달입니다.', '이것은 탭2 모달입니다.', '이것은 탭3 모달입니다.'];
    final inputButtonTexts = [
      tabCompleted[0] ? '탭1완료' : '탭1입력',
      tabCompleted[1] ? '탭2완료' : '탭2입력',
      tabCompleted[2] ? '탭3완료' : '탭3입력',
    ];
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 탭 버튼 3개
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _selectedTab == i ? Colors.green : Colors.grey[300],
                    foregroundColor:
                        _selectedTab == i ? Colors.white : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedTab = i;
                    });
                  },
                  child: Text('탭${i + 1}'),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(tabTexts[_selectedTab], style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('닫기'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed:
                      tabCompleted[_selectedTab]
                          ? () => _handleCompleteButton(_selectedTab)
                          : () => _openProfileInputPage(_selectedTab),
                  child: Text(inputButtonTexts[_selectedTab]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
