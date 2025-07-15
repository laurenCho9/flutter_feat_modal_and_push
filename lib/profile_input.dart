import 'package:flutter/material.dart';

class ProfileInputPage extends StatefulWidget {
  final int initialTab;
  const ProfileInputPage({super.key, this.initialTab = 0});

  @override
  State<ProfileInputPage> createState() => _ProfileInputPageState();
}

class _ProfileInputPageState extends State<ProfileInputPage> {
  late int _selectedTab;

  final List<String> tabTitles = ['탭1', '탭2', '탭3'];
  final List<String> tabDescriptions = [
    '탭1에 대한 설명입니다.',
    '탭2에 대한 설명입니다.',
    '탭3에 대한 설명입니다.',
  ];

  @override
  void initState() {
    super.initState();
    _selectedTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필입력'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 탭 버튼
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
                    child: Text(tabTitles[i]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
            // 탭별 설명글
            Text(
              tabDescriptions[_selectedTab],
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('저장하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
