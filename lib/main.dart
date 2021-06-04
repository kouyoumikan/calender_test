import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calendar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarController _controller;

  File _image;
  final picker = ImagePicker();

  Future getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Calendar'),
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              initialCalendarFormat: CalendarFormat.week,
              calendarStyle: CalendarStyle(
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                print(date.toIso8601String());
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),

            // MEMO用のテキストボックス1
        Container(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: [
              SizedBox(
                width: 150.0,
                height: 30.0,
                child: RaisedButton(
                  //onPressed: () {},
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  shape: StadiumBorder(), // 両サイド丸のボタン
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient( // グラデーションのボタン
                        colors: <Color>[
                          Colors.blue.shade300,
                          Colors.blue.shade500,
                          Colors.blue.shade700,
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 200.0, 10.0),
                    child: const Text('Raised Button'),
                  ),
//                  child: const Text('入力データのある日付'),
//                  color: Colors.orange,
//                  textColor: Colors.white,
//                  shape: StadiumBorder(), // 両サイド丸のボタン
                ),
              ),

              SizedBox(
                height: 3.0,
              ),

              SizedBox(
                width: 400.0,
                height: 150.0,
                child: TextField(
                  // テキストを複数行入力できるようにする
                  keyboardType: TextInputType.multiline, // キーボードのエンターキーで改行
                  //maxLines: null, // maxLinesはnullを指定すると、どこまででも改行(自動折り返し)
                  maxLines: 5, // maxLinesは入力可能な最大行数を指定
                  minLines: 2, // minLinesは入力可能な最小行数を指定
                  decoration: InputDecoration(
                    // TextFieldの内側のPaddingを変更する方法
                    //contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                    contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 50.0, 10.0),
                    border: OutlineInputBorder(),
                    labelText: 'Happy Memo',
                    hintText: 'Memo',
                  ),
                  autofocus: false,
                ),
              ),

            // MEMO用のテキストボックス2
            Container(
                width: 350,
                height: 300,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Happy Memo',
                    hintText: 'Memo',
                  ),
                  autofocus: false,
                ),
            ),

//              Center(
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.center,
//                  children: [
//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Container(
//                          width: 300,
//                          child: _image == null
//                              ? Text('No image selected.')
//                              : Image.file(_image)),
//                    ),
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceAround,
//                      children: [
//                        FloatingActionButton(
//                          onPressed: getImageFromCamera,
//                          tooltip: 'Pick Image From Camera',
//                          child: Icon(Icons.add_a_photo),
//                        ),
//                        FloatingActionButton(
//                          onPressed: getImageFromGallery,
//                          tooltip: 'Pick Image From Gallery',
//                          child: Icon(Icons.photo_library),
//                        ),
//                      ],
//                    )
//                  ],
//                ),
//              ),

          ],
        ),
      ),


    ],
        ),


      ),
    );
  }
}
