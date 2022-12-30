import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nat_corp_admin/calls/meeting_screen.dart';
import 'package:nat_corp_admin/services/data/api.dart';
import 'package:nat_corp_admin/widgets/text_widget.dart';
import 'package:videosdk/videosdk.dart';

class VideoSDKQuickStart extends StatefulWidget {
  const VideoSDKQuickStart({Key? key}) : super(key: key);

  @override
  State<VideoSDKQuickStart> createState() => _VideoSDKQuickStartState();
}

class _VideoSDKQuickStartState extends State<VideoSDKQuickStart> {
  String meetingId = "";
  bool isMeetingActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            TextRegular(text: 'Interview', fontSize: 18, color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isMeetingActive
            ? MeetingScreen(
                meetingId: meetingId,
                token: token,
                leaveMeeting: () {
                  setState(() => isMeetingActive = false);
                },
              )
            : JoinScreen(
                onMeetingIdChanged: (value) => meetingId = value,
                onCreateMeetingButtonPressed: () async {
                  meetingId = await createMeeting();
                  setState(() => isMeetingActive = true);
                },
                onJoinMeetingButtonPressed: () {
                  setState(() => isMeetingActive = true);
                },
              ),
      ),
    );
  }
}

class JoinScreen extends StatelessWidget {
  final void Function() onCreateMeetingButtonPressed;
  final void Function() onJoinMeetingButtonPressed;
  final void Function(String) onMeetingIdChanged;

  JoinScreen({
    Key? key,
    required this.onCreateMeetingButtonPressed,
    required this.onJoinMeetingButtonPressed,
    required this.onMeetingIdChanged,
  }) : super(key: key);

  final box = GetStorage();

  late Room room;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        color: Colors.teal[700],
        height: 50,
        minWidth: 200,
        child: TextRegular(text: room.id, fontSize: 14, color: Colors.white),
        onPressed: onCreateMeetingButtonPressed,
      ),
    ));
  }
}
