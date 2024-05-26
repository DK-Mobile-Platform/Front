/*
파일 저장 메서드
void saveToFile() {
  // 파일 저장 코드를 여기에 구현합니다.
  print("파일을 저장합니다.");
}
*/

/*
요약 기록 저장 다이얼로그 표시 메서드
void showSaveRecordDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("요약 기록을 저장하시겠습니까?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("저장 폴더 선택"),
            TextFormField(
              onChanged: (value) {
                // 폴더 이름을 저장합니다.
              },
            ),
            SizedBox(height: 10),
            Text("저장 이름"),
            TextFormField(
              onChanged: (value) {
                // 파일 이름을 저장합니다.
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              saveToFile(); // 파일 저장 메서드 호출
            },
            child: Text("예"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("아니요"),
          ),
        ],
      );
    },
  );
}
*/
