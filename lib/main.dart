import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skills_competition_ex/constants/app_colors.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skills_competition_ex/InitialSettings.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // runApp 전에 호출

  KakaoSdk.init(
    nativeAppKey: 'd8b4041c5d9a8063489176b8d04387c5', // 카카오 개발자 콘솔에서 복사
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyIntroPage(),
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // 이게 핵심
      ],
      supportedLocales: [Locale('ko', 'KR')],
    );
  }
}

class MyIntroPage extends StatefulWidget {
  const MyIntroPage({super.key});

  @override
  State<MyIntroPage> createState() => _MyIntroPageState();
}

class _MyIntroPageState extends State<MyIntroPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MyLoginPage(),
          transitionDuration: const Duration(milliseconds: 600),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 280),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Planfit',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 40,
                  fontWeight: FontWeight(800),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  Future<void> _kakaoLogin() async {
    try {
      if (await isKakaoTalkInstalled()) {
        await UserApi.instance.loginWithKakaoTalk();
      } else {
        await UserApi.instance.loginWithKakaoAccount();
      }
      // 로그인 성공 시 페이지 이동
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const InitialSettings()),
      );
    } catch (e) {
      print('카카오 로그인 실패: $e');
    }
  }

  Future<void> _appleLogin() async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      print('애플 로그인 성공: ${credential.userIdentifier}');
      // 로그인 성공 시 페이지 이동
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const InitialSettings()),
      );
    } catch (e) {
      print('애플 로그인 실패: $e');
    }
  }

  Future<void> _googleLogin() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? account = await googleSignIn.signIn();

      if (account != null) {
        print('구글 로그인 성공: ${account.email}');
        Navigator.pushReplacement(
          context,
          CupertinoPageRoute(builder: (context) => const InitialSettings()),
        );
      }
    } catch (e) {
      print('구글 로그인 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(size: Size.infinite, painter: BackgroundPainter()),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 150),
                    Text(
                      '운동 고민 끝,\n플랜핏에 오신 것을\n환영합니다!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight(800),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Text(
                      '3초 가입으로 바로 시작해보세요',
                      style: TextStyle(
                        color: const Color.fromARGB(198, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight(500),
                      ),
                    ),

                    const SizedBox(height: 200),

                    //카카오톡 버튼
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xfffee402),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      onPressed: _kakaoLogin,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Image.asset(
                              'assets/kakaotalk.png',
                              width: 20,
                            ),
                          ),

                          Text(
                            textAlign: TextAlign.center,
                            '카카오로 계속하기',
                            style: TextStyle(
                              color: Color(0xff1f2125),
                              fontSize: 16,
                              fontWeight: FontWeight(800),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 15),

                    //Apple로 계속하기
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: Size(double.infinity, 50),
                        padding: EdgeInsets.only(left: 10),
                      ),
                      onPressed: _appleLogin,

                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Icon(
                              Icons.apple,
                              size: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Apple로 계속하기',
                            style: TextStyle(
                              color: Color(0xff1f2125),
                              fontSize: 16,
                              fontWeight: FontWeight(800),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    //Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(color: Colors.white, thickness: 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            '또는',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Divider(color: Colors.white, thickness: 1),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    //google & facebook Login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //구글 로그인
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(50, 50),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: _googleLogin,
                          child: Image.asset(
                            'assets/googleLogo.png',
                            width: 20,
                          ),
                        ),

                        const SizedBox(width: 30),

                        //페이스북 로그인
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff1776f1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: Size(50, 50),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => const InitialSettings(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/facebookLogo.png',
                            width: 22,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '로그인하시면 아래 내용에 동의하는 것으로 간주됩니다.',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '개인정보처리방침',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Text(
                              '이용약관',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors
          .secondBackground // 밝은 회색 영역
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height); // 왼쪽 하단
    path.lineTo(size.width, size.height); // 오른쪽 하단
    path.lineTo(size.width, size.height * 0.35); // 오른쪽 위 (높음)
    // 오른쪽 볼록, 왼쪽 오목 곡선
    path.cubicTo(
      size.width * 0.6,
      size.height * 0.35, // 오른쪽 조절점 (볼록 유지)
      size.width * 0.4,
      size.height * 0.6, // 왼쪽 조절점 (오목하게 당김)
      0,
      size.height * 0.6, // 왼쪽 끝점
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
