import 'package:flutter/material.dart';

class ProfileInputPage extends StatefulWidget {
  final int initialTab;
  const ProfileInputPage({super.key, this.initialTab = 0});

  @override
  State<ProfileInputPage> createState() => _ProfileInputPageState();
}

class _ProfileInputPageState extends State<ProfileInputPage> {
  late int _selectedTab;

  final List<String> tabTitles = ['프로필', '육각형', '탈모MBTI'];
  final List<String> tabDescriptions = [
    '프로필에 대한 설명입니다.',
    '육각형에 대한 설명입니다.',
    '탈모MBTI에 대한 설명입니다.',
  ];
  final List<String> saveButtonTexts = ['프로필저장하기', '육각형저장하기', '탈모MBTI저장하기'];

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
                onPressed: () {
                  Navigator.of(context).pop(_selectedTab);
                },
                child: Text(saveButtonTexts[_selectedTab]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
