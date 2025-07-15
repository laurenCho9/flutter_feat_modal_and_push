import 'package:flutter/material.dart';

class CustomModal extends StatefulWidget {
  const CustomModal({super.key});

  @override
  State<CustomModal> createState() => _CustomModalState();
}

class _CustomModalState extends State<CustomModal> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
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
          const Text('이것은 모달입니다.', style: TextStyle(fontSize: 18)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}
