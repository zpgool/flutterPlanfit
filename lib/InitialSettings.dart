import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:skills_competition_ex/constants/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InitialSettings extends StatefulWidget {
  const InitialSettings({super.key});

  @override
  State<InitialSettings> createState() => _InitialSettingsState();
}

class _InitialSettingsState extends State<InitialSettings> {
  int currentStep = 1;
  int totalStep = 9;
  final PageController _pageController = PageController();

  bool isHome = false;
  bool isAnimating = false;

  final List<String> stepTitles = [
    '운동 수준',
    '운동 장소',
    '헬스장 설정',
    '운동 목표',
    '신체 목표',
    '신체 정보',
    '신체 정보',
    '추가 질문',
    '',
  ];

  List<Widget> get pages => [
    Step1Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step2Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
      onSkip: () {
        setState(() {
          currentStep = 4;
          isHome = true;
        });
        _pageController.animateToPage(
          3,
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step3Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step4Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step5Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step6Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step7Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step8Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
    Step9Page(
      onNext: () {
        setState(() {
          if (currentStep < totalStep) currentStep++;
        });
        _pageController.nextPage(
          duration: Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 70),

            // 타이틀
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                //뒤로가기버튼
                if (currentStep > 1)
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () async {
                      if (isAnimating) return; //애니메이션 중이면 무시

                      setState(() => isAnimating = true);

                      if (currentStep == 4 && isHome) {
                        setState(() {
                          currentStep = 2;
                          isHome = false;
                        });
                        await _pageController.animateToPage(
                          1,
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        setState(() {
                          if (currentStep > 1) currentStep--;
                        });
                        await _pageController.previousPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      }

                      setState(() => isAnimating = false);
                    },
                  )
                else
                  const SizedBox(height: 48),
                //타이틀
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    stepTitles[currentStep - 1],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight(800),
                    ),
                  ),
                ),
                //건너뛰기
                if (currentStep == 3)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          currentStep++;
                        });
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        '건너뛰기',
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 15),

            // 진행 바
            ProgressBar(currentStep: currentStep, totalStep: totalStep),

            const SizedBox(height: 30),

            // PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                children: pages,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Step1Page extends StatelessWidget {
  final VoidCallback onNext;

  const Step1Page({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '운동 수준이 어떻게 되시나요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          '적절한 운동 추천이 필요해요! 외부에 공개되지 않아요.',
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),

        const Spacer(),

        LevelBox(
          title: '입문',
          explainText: '운동 자세, 운동 루틴 등 아무것도 몰라요',
          onTap: onNext,
        ),
        const SizedBox(height: 10),
        LevelBox(
          title: '초급',
          explainText: '자세는 조금 알지만 무슨 운동을 해야 할지 몰라요',
          onTap: onNext,
        ),
        const SizedBox(height: 10),
        LevelBox(
          title: '중급',
          explainText: '운동 자세를 잘 알고, 나만의 루틴이 있어요',
          onTap: onNext,
        ),
        const SizedBox(height: 10),
        LevelBox(
          title: '고급',
          explainText: '운동을 직업으로 삼을 만큼의 지식이 있어요',
          onTap: onNext,
        ),
        const SizedBox(height: 10),
        LevelBox(
          title: '전문가',
          explainText: '운동 선수급의 지식과 경험이 있어요',
          onTap: onNext,
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class Step2Page extends StatelessWidget {
  final VoidCallback onNext;
  final VoidCallback onSkip;

  const Step2Page({super.key, required this.onNext, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주로 어디서 운동하시나요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),

        const SizedBox(height: 15),

        Text(
          '장소에 맞게 운동을 구성해 드릴게요.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const Spacer(),

        LocationBox(title: '헬스장', onTap: onNext),
        const SizedBox(height: 10),
        LocationBox(title: '집', onTap: onSkip),
        const SizedBox(height: 60),
      ],
    );
  }
}

class Step3Page extends StatefulWidget {
  final VoidCallback onNext;

  const Step3Page({super.key, required this.onNext});

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _results = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onSearch(String query) async {
    if (query.isEmpty) {
      setState(() => _results = []);
      return;
    }

    final response = await http.get(
      Uri.parse(
        'https://dapi.kakao.com/v2/local/search/keyword.json?query=$query 헬스장',
      ),
      headers: {'Authorization': 'KakaoAK 58673e1000206a69fc553b18498746a1'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _results = (data['documents'] as List)
            .map<Map<String, String>>(
              (e) => {
                'name': e['place_name'] as String,
                'address': e['road_address_name'] as String,
                'zip':
                    (e['road_address'] as Map<String, dynamic>?)?['zone_no']
                        as String? ??
                    '',
              },
            )
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '다니시는 헬스장은 어디인가요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(800),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '헬스장에 있는 기구에 딱 맞게 추천해 드릴게요.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 30),

        // 검색창
        TextField(
          controller: _controller,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            hintText: '주소로 검색하면 더 빠르게 찾을 수 있어요!',
            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            filled: true,
            fillColor: AppColors.secondBackground,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
          ),
          onChanged: _onSearch,
        ),

        // 검색 결과
        Expanded(
          child: ListView.builder(
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final place = _results[index];
              return GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: 330),
                    context: context,
                    backgroundColor: AppColors.secondBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(30),
                      ),
                    ),
                    builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 40,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '아래 헬스장에 다니고 계신게 맞나요?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight(800),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Text(
                            place['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight(700),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Container(
                                width: 57,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Color(0xffd7e7fe),
                                  borderRadius: BorderRadius.circular(50),
                                ),

                                child: Center(
                                  child: Text(
                                    '도로명',
                                    style: TextStyle(
                                      color: Color(0xff2f62ce),
                                      fontSize: 11,
                                      fontWeight: FontWeight(800),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                place['address']!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),

                          const SizedBox(height: 3),

                          Row(
                            children: [
                              Container(
                                width: 57,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: Color(0xff636773),
                                  borderRadius: BorderRadius.circular(50),
                                ),

                                child: Center(
                                  child: Text(
                                    '우편번호',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 11,
                                      fontWeight: FontWeight(800),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                place['zip']!.isEmpty ? '정보 없음' : place['zip']!,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xff272a2e),
                                    minimumSize: Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    '다시 검색',
                                    style: TextStyle(
                                      color: Color(0xffc7c7c9),
                                      fontSize: 20,
                                      fontWeight: FontWeight(800),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.textPrimary,
                                    minimumSize: Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(17),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    widget.onNext();
                                  },
                                  child: Text(
                                    '네, 맞아요',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight(800),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      place['name']!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight(700),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          width: 57,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(0xffd7e7fe),
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: Center(
                            child: Text(
                              '도로명',
                              style: TextStyle(
                                color: Color(0xff2f62ce),
                                fontSize: 11,
                                fontWeight: FontWeight(800),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          place['address']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),

                    const SizedBox(height: 3),

                    Row(
                      children: [
                        Container(
                          width: 57,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Color(0xff636773),
                            borderRadius: BorderRadius.circular(50),
                          ),

                          child: Center(
                            child: Text(
                              '우편번호',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight(800),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          place['zip']!.isEmpty ? '정보 없음' : place['zip']!,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class Step4Page extends StatelessWidget {
  final VoidCallback onNext;

  const Step4Page({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '일주일에 몇 번 운동하실\n예정이신가요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),

        const SizedBox(height: 15),

        Text(
          '언제든 변경할 수 있어요.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const Spacer(),

        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CountBox(title: '1회', onTap: onNext),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CountBox(title: '2회', onTap: onNext),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CountBox(title: '3회', onTap: onNext),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CountBox(title: '4회', onTap: onNext),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CountBox(title: '5회', onTap: onNext),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CountBox(title: '6회', onTap: onNext),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 60),
      ],
    );
  }
}

class Step5Page extends StatefulWidget {
  final VoidCallback onNext;
  const Step5Page({super.key, required this.onNext});

  @override
  State<Step5Page> createState() => _Step5PageState();
}

class _Step5PageState extends State<Step5Page> {
  Set<String> selected = {}; // 선택된 항목들

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '주요 목표는 무엇인가요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const Spacer(),
        Wrap(
          spacing: 9,
          runSpacing: 8,
          children:
              [
                    '평생 숙제 다이어트',
                    '뱃살, 옆구리살 빼기',
                    '팔뚝 군살 제거',
                    '슬립한 하체 라인 만들기',
                    '벌크업 하기',
                    '넓은 어께 갖기',
                    '마른 몸 벗어나기',
                    '굵고 큰 팔 만들기',
                    '탄탄한 몸 만들기',
                    '힙업',
                    '전체적인 근육량 증가',
                    '선명한 복근 만들기',
                  ]
                  .map(
                    (title) => GestureDetector(
                      onTap: () {
                        setState(() {
                          if (selected.contains(title)) {
                            selected.remove(title);
                          } else {
                            selected.add(title);
                          }
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.secondBackground,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected.contains(title)
                                ? AppColors
                                      .textPrimary // 선택됐을 때 색
                                : Colors.transparent, // 선택 안됐을 때 투명
                            width: 2,
                          ),
                        ),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                  .toList(),
        ),

        const SizedBox(height: 80),
        // 다음 버튼 (하나 이상 선택됐을 때만 활성화)
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(100, 55),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(17),
              ),
            ),
            onPressed: selected.isEmpty ? null : widget.onNext,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: 200,
              height: 55,
              decoration: BoxDecoration(
                color: selected.isEmpty
                    ? Colors.transparent
                    : AppColors.textPrimary,
                borderRadius: BorderRadius.circular(17),
              ),
              child: Center(
                child: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 100),
                  style: TextStyle(
                    color: selected.isEmpty ? Colors.transparent : Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight(800),
                  ),
                  child: Text('다음'),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class Step6Page extends StatelessWidget {
  final VoidCallback onNext;

  const Step6Page({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '성별이 어떻게 되시나요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const Spacer(),

        LocationBox(title: '남성', onTap: onNext),
        const SizedBox(height: 10),
        LocationBox(title: '여성', onTap: onNext),
        const SizedBox(height: 10),
        LocationBox(title: '기타', onTap: onNext),

        const SizedBox(height: 60),
      ],
    );
  }
}

class Step7Page extends StatefulWidget {
  final VoidCallback onNext;

  const Step7Page({super.key, required this.onNext});

  @override
  State<Step7Page> createState() => _Step7PageState();
}

class _Step7PageState extends State<Step7Page> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  bool get _canNext =>
      _birthDate != null &&
      _heightController.text.isNotEmpty &&
      _weightController.text.isNotEmpty;

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  DateTime? _birthDate;

  void _showDatePicker(BuildContext context) {
    DateTime tempDate = _birthDate ?? DateTime(2000, 1, 1);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.secondBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 250,
            child: CupertinoTheme(
              data: CupertinoThemeData(
                textTheme: CupertinoTextThemeData(
                  dateTimePickerTextStyle: TextStyle(
                    color: Colors.white, // 글자 색
                    fontSize: 20,
                  ),
                ),
              ),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: tempDate,
                onDateTimeChanged: (date) {
                  tempDate = date;
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 55),
                backgroundColor: AppColors.textPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
              onPressed: () {
                setState(() => _birthDate = tempDate);
                Navigator.pop(context);
              },
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight(800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '신체 정보를 알려주세요',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '적절한 운동 추천에 필요해요! 외부에 공개되지 않아요.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 50),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),

          child: Column(
            children: [
              //생년월일
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '생년월일',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight(700),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _showDatePicker(context),
                    child: Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.secondBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          _birthDate == null
                              ? ''
                              : '${_birthDate!.year}.${_birthDate!.month.toString().padLeft(2, '0')}.${_birthDate!.day.toString().padLeft(2, '0')}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight(700),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //키
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '키',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight(700),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: TextField(
                      controller: _heightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight(700),
                      ),
                      decoration: InputDecoration(
                        suffixText: 'cm',
                        suffixStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: AppColors.secondBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.textPrimary,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              //몸무게
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '몸무게',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight(700),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    height: 50,
                    child: TextField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight(700),
                      ),
                      decoration: InputDecoration(
                        suffixText: 'kg',
                        suffixStyle: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        filled: true,
                        fillColor: AppColors.secondBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: AppColors.textPrimary,
                            width: 1,
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const Spacer(),

        // 다음 버튼
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(17),
            ),
          ),
          onPressed: _canNext ? widget.onNext : null,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            width: 200,
            height: 55,
            decoration: BoxDecoration(
              color: _canNext
                  ? AppColors.textPrimary
                  : Colors.grey.withOpacity(0.3),
              borderRadius: BorderRadius.circular(17),
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: Duration(milliseconds: 200),
                style: TextStyle(
                  color: _canNext ? Colors.black : Colors.transparent,
                  fontSize: 18,
                  fontWeight: FontWeight(800),
                ),
                child: Text('다음'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 60),
      ],
    );
  }
}

class Step8Page extends StatelessWidget {
  final VoidCallback onNext;

  const Step8Page({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '플랫핏을 어떻게 알게 되셨나요?',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),

        const Spacer(),

        QuestionBox(title: '인스타그램/페이스북', onTap: onNext),
        const SizedBox(height: 10),
        QuestionBox(title: '기타', onTap: onNext),
        const SizedBox(height: 10),
        QuestionBox(title: '유튜브', onTap: onNext),
        const SizedBox(height: 10),
        QuestionBox(title: '지인 추천', onTap: onNext),
        const SizedBox(height: 10),
        QuestionBox(title: '블로그/카페/커뮤니티', onTap: onNext),

        const SizedBox(height: 60),
      ],
    );
  }
}

class Step9Page extends StatelessWidget {
  final VoidCallback onNext;

  const Step9Page({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '작심삼일,\n벗어날 수 있도록 도와드릴게요',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight(700),
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '꾸준히 운동하는 플랜핏 회원 95%가\n알림을 받고 있습니다.',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }
}

//페이지1박스
class LevelBox extends StatelessWidget {
  final String title;
  final String explainText;
  final VoidCallback onTap;

  const LevelBox({
    super.key,
    required this.title,
    required this.explainText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 70),
        backgroundColor: AppColors.secondBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight(800),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              explainText,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

//페이지2,6박스
class LocationBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const LocationBox({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 70),
        backgroundColor: AppColors.secondBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight(800),
            ),
          ),
        ],
      ),
    );
  }
}

//페이지4박스
class CountBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const CountBox({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(0, 50),
        backgroundColor: AppColors.secondBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        padding: EdgeInsets.zero,
      ),
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight(800),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//페이지8박스
class QuestionBox extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const QuestionBox({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: Size(double.infinity, 60),
            backgroundColor: AppColors.secondBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.zero,
          ),
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight(800),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

//페이지9박스


//단계 바
class ProgressBar extends StatelessWidget {
  final int currentStep;
  final int totalStep;

  const ProgressBar({
    super.key,
    required this.currentStep,
    required this.totalStep,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Container(
              width: constraints.maxWidth,
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.secondBackground,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              width: constraints.maxWidth * (currentStep / totalStep),
              height: 7,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ],
        );
      },
    );
  }
}
