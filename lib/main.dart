import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:uuid/uuid.dart';
import 'package:permission_handler/permission_handler.dart'; // 権限のリクエストに必要

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget { // StatefulWidgetに変更
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();
    requestPermissions(); // アプリ起動時に権限をリクエスト
  }

  Future<void> requestPermissions() async {
    await Permission.phone.request();
  }

  Future<void> showIncomingCall() async {
    final String callId = uuid.v4(); // UUIDを生成

    CallKitParams callKitParams = CallKitParams(
      id: callId,
      nameCaller: 'Hien Nguyen',
      appName: 'Callkit',
      avatar: 'https://i.pravatar.cc/100',
      handle: '0123456789',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      missedCallNotification: NotificationParams(
        showNotification: true,
        isShowCallback: true,
        subtitle: 'Missed call',
        callbackText: 'Call back',
      ),
      duration: 30000,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
      android: const AndroidParams(
          isCustomNotification: true,
          isShowLogo: false,
          ringtonePath: 'system_ringtone_default',
          backgroundColor: '#0955fa',
          backgroundUrl: 'https://i.pravatar.cc/500',
          actionColor: '#4CAF50',
          textColor: '#ffffff',
          incomingCallNotificationChannelName: "Incoming Call",
          missedCallNotificationChannelName: "Missed Call",
          isShowCallID: false
      ),
      ios: IOSParams(
        iconName: 'CallKitLogo',
        handleType: 'generic',
        supportsVideo: true,
        maximumCallGroups: 2,
        maximumCallsPerCallGroup: 1,
        audioSessionMode: 'default',
        audioSessionActive: true,
        audioSessionPreferredSampleRate: 44100.0,
        audioSessionPreferredIOBufferDuration: 0.005,
        supportsDTMF: true,
        supportsHolding: true,
        supportsGrouping: false,
        supportsUngrouping: false,
        ringtonePath: 'system_ringtone_default',
      ),
    );
    await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
    /*
    final params = CallKitParams.fromJson(<String, dynamic>{
      //'id': 'callkit_incoming_test',
      'id': callId, // UUIDを使用
      'nameCaller': 'Flutter Caller',
      'appName': 'CallKit Demo',
      'avatar': 'https://your_avatar_url.com', // 適切なURLを設定
      'handle': '0123456789',
      'type': 0, // 0: 音声, 1: ビデオ
      'duration': 30000, // 呼び出し時間（ミリ秒）
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'extra': <String, dynamic>{'userId': 'user_id'},
      'headers': <String, dynamic>{'apiKey': 'api_key'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': true,
        'ringtonePath': 'system_ringtone_default',
      },
      'ios': <String, dynamic>{
        'iconName': 'AppIcon', // アイコン名
        'handleType': 'generic', // 電話番号のタイプ (generic, number, email)
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'supportsHolding': true,
        'supportsDTMF': true,
        'supportsMultiTasking': false,
      },
    });

    try {
      await FlutterCallkitIncoming.showCallkitIncoming(params);
    } catch (e) {
      print('Error showing incoming call: $e');
    }
*/
  /*
  Future<void> showIncomingCall() async {
    final params = CallKitParams.fromJson(<String, dynamic>{
      'id': 'callkit_incoming_test',
      'nameCaller': 'Flutter Caller',
      'appName': 'CallKit Demo',
      'avatar': 'https://your_avatar_url.com', // 着信画面に表示する画像URL
      'handle': '0123456789', // 電話番号やID
      'type': 0, // 0: 音声, 1: ビデオ
      'duration': 30000, // 呼び出し時間（ミリ秒）
      'textAccept': 'Accept',
      'textDecline': 'Decline',
      'textMissedCall': 'Missed call',
      'textCallback': 'Call back',
      'extra': <String, dynamic>{'userId': 'user_id'},
      'headers': <String, dynamic>{'apiKey': 'api_key'},
      'android': <String, dynamic>{
        'isCustomNotification': true,
        'isShowLogo': false,
        'isShowCallback': true,
        'ringtonePath': 'system_ringtone_default',
      },
      'ios': <String, dynamic>{
        'iconName': 'AppIcon', // アイコン名
        'handleType': 'generic', // 電話番号のタイプ (generic, number, email)
        'supportsVideo': true,
        'maximumCallGroups': 2,
        'maximumCallsPerCallGroup': 1,
        'audioSessionMode': 'default',
        'audioSessionActive': true,
        'supportsHolding': true,
        'supportsDTMF': true,
        'supportsMultiTasking': false,
      },
    });

    await FlutterCallkitIncoming.showCallkitIncoming(params);
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CallKit Incoming Demo'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showIncomingCall();
          },
          child: Text('Show Incoming Call'),
        ),
      ),
    );
  }
}