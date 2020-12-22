import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<String> dataStringList = [];
List <List> allData = [];
int numberOfLetterPacks;

class LetterSet{
  String name;
  List <String> position;
  List<String> letters;

  LetterSet(String nameString, List<String> positionList, List<String> letterList){
    name = nameString;
    position = positionList;
    if (positionList[0] == "sides"){
      position = ["beginning", "end"];
    }
    if (positionList[0] == "all"){
      position = ["beginning", "middle", "end"];
    }
    if (positionList[0] == "latterHalf"){
      position = ["middle", "end"];
    }
    letters = letterList;
  }
  
  void dataEncode(List<String> stringList){
    stringList.add("#" + name);
    stringList.add(position[0]);
    for(int i=0; i<letters.length; i++){
      stringList.add(letters[i]);
    }
  }
  void letterSetInfo(){
    print (name);
    print (position);
    print (letters);
  }
  
}

class LetterPack{
  String name;
  LetterSet beginning;
  LetterSet middle;
  LetterSet end;
  
  List<LetterSet> sets;
  
  LetterPack(String nameString, LetterSet beg, LetterSet mid, LetterSet e){
    name = nameString;
    beginning = beg;
    middle = mid;
    end = e;
    
    sets = [beginning, middle, end];
    
  }
  void dataEncode(List<String> stringList){
    stringList.add(name);
    beginning.dataEncode(stringList);
    middle.dataEncode(stringList);
    end.dataEncode(stringList);
  }
  
  void letterPackInfo(){
    print (name);
    print (beginning.name);
    print (beginning.letters);
    print (middle.name);
    print (middle.letters);
    print (end.name);
    print (end.letters);
  }
  
  static void encodeAll(){
    for (int i=0; i<allPacks.length; i++){
      List <String> temp = [];
      allPacks[i].dataEncode(temp);
      //add stuff from temp into dataStringList
      allData.add(temp);
    }
  }
  static LetterPack decodeLetterPack(List <String> letterSetList){
    LetterPack tempLP;
    String letterPackName = "";
    LetterSet tempLS1;
    LetterSet tempLS2;
    LetterSet tempLS3;
    int index1;
    int index2;
    int index3;
    String letterSetName1 = "";
    String letterSetName2 = "";
    String letterSetName3 = "";
    List<String> position1 = [];
    List<String> position2 = [];
    List<String> position3 = [];
    List<String> lettersList1 = [];
    List<String> lettersList2 = [];
    List<String> lettersList3 = [];
    int count = 0;
    
    for(int i =0; i<letterSetList.length; i++){
       if(letterSetList[i][0] == "#"){
         count++;
         if(count == 1){
           index1 = i;
           letterSetName1 = letterSetList[i].substring(1,letterSetList[i].length);
           position1.add(letterSetList[i+1]);
         }
         if(count == 2){
           index2 = i;
           letterSetName2 = letterSetList[i].substring(1,letterSetList[i].length);
           position2.add(letterSetList[i+1]);
         }
         if(count == 3){
           index3 = i;
           letterSetName3 = letterSetList[i].substring(1,letterSetList[i].length);
           position3.add(letterSetList[i+1]);
         }
       }
    }
    letterPackName = letterSetList[0];
    lettersList1 = letterSetList.sublist(index1+2, index2);
    lettersList2 = letterSetList.sublist(index2+2, index3);
    lettersList3 = letterSetList.sublist(index3+2);
    
    tempLS1 = new LetterSet(letterSetName1, position1, lettersList1);
    tempLS2 = new LetterSet(letterSetName2, position2, lettersList2);
    tempLS3 = new LetterSet(letterSetName3, position3, lettersList3);
    tempLP = new LetterPack(letterPackName, tempLS1, tempLS2, tempLS3);
    return tempLP;

  }
  //decodeAll will take allData and update allPacks.
  static void decodeAll(){
    //allPacks is a list of letterpacks
    allPacks.clear();
    //allData is a list of stringLists
    //decodeLetterPack converts stringList into a letterPack
    for (int i=0; i<allData.length; i++){
      allPacks.add(decodeLetterPack(allData[i]));
    }
  }
  
}
LetterSet singleConsonantsBeginning = new LetterSet("Single Consonants", ["beginning"], ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "qu", "r", "s", "t", "v", "w", "x", "y", "z"]);  
LetterSet singleConsonantsEnding = new LetterSet("Single Consonants",["end"], ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "r", "s", "t", "v", "w", "x", "y", "z"]);
LetterSet hBrothers = LetterSet("H Brothers", ["sides"], ["ch", "ph", "sh", "th", "wh"]);
LetterSet beginningBlends = LetterSet("Beginning Blends", ["beginning"], ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "gr", "pl", "pr", "sc", "scr", "shr", "sk", "sl", "sm", "sn", "sp", "spl", "spr", "squ", "st", "str", "sw", "thr", "tr", "tw"]);
LetterSet shortVowelPointers = LetterSet("Short Vowel Pointers", ["latterHalf"], ["ck", "dge", "tch", "ff", "ll", "ss", "zz"]);
LetterSet endingBlends = LetterSet("Ending Blends", ["end"], ["sk", "sp", "st", "ct", "ft", "lk", "lt", "mp", "nch", "nd", "nt", "pt"]);
LetterSet magicEEnding = LetterSet("Magic E", ["end"], ["be", "ce", "de", "fe", "ge", "ke", "le", "me", "ne", "pe", "se", "te"]);
LetterSet closedSyllable = LetterSet("Closed Syllable", ["middle"], ["a", "e", "i", "o", "u"]);
LetterSet openSyllable = LetterSet("Open Syllable", ["middle"], ["a", "e", "i", "o", "u"]);
LetterSet magicEMiddle = LetterSet("Magic E", ["middle"], ["a", "e", "i", "o", "u"]);
LetterSet controlledR = LetterSet("Controlled R", ["middle"], ["ar", "er", "ir", "or", "ur"]);
LetterSet shortVowelExceptions = LetterSet("Short Vowel Exceptions", ["middle"], ["ang", "ank", "ild", "ind", "ing", "ink", "old", "oll", "olt", "ong", "onk", "ost", "ung", "unk"]);
LetterSet vowelTeamBasic = LetterSet("Vowel Team Basic", ["middle"], ["ai", "ay", "ea", "ee", "igh", "oa", "oy"]);
LetterSet vowelTeamIntermediate = LetterSet("Vowel Team Intermediate", ["middle"], ["aw", "eigh", "ew", "ey", "ie", "oe", "oi", "oo", "ou", "ow"]);
LetterSet vowelTeamAdvanced = LetterSet("Vowel Team Advanced", ["middle"], ["aw", "eigh", "ew", "ey", "ie", "oe", "oi", "oo", "ou", "ow"]);
LetterSet vowelA = LetterSet("Vowel A", ["middle"], ["al", "all", "wa", "al", "all", "wa"]);
LetterSet empty = LetterSet("Empty", ["all"], ["", "", "", ""]);
  
List<LetterSet> allSets = [singleConsonantsBeginning, singleConsonantsEnding,  hBrothers, beginningBlends, endingBlends, magicEEnding, closedSyllable, openSyllable, magicEMiddle, shortVowelPointers,  controlledR, shortVowelExceptions, vowelTeamBasic, vowelTeamIntermediate, vowelTeamAdvanced, vowelA, empty];
//var letterSetMap = {singleConsonantsBeginning.name: singleConsonantsBeginning, singleConsonantsEnding.name: singleConsonantsEnding, hBrothers.name:hBrothers, beginningBlends.name: beginningBlends, shortVowelPointers.name: shortVowelPointers, endingBlends.name: endingBlends, magicEEnding.name: magicEEnding, closedSyllable.name: closedSyllable, openSyllable.name: openSyllable, magicEMiddle.name: magicEMiddle, controlledR.name: controlledR, shortVowelExceptions.name: shortVowelExceptions, vowelTeamBasic.name: vowelTeamBasic, vowelTeamIntermediate.name: vowelTeamIntermediate, vowelTeamAdvanced.name: vowelTeamAdvanced,vowelA.name: vowelA, empty.name: empty};

LetterPack standardClosed = LetterPack("Standard (Closed Syllable)", singleConsonantsBeginning, closedSyllable, singleConsonantsEnding);
LetterPack standardOpen = LetterPack("Standard (Open Syllable)", singleConsonantsBeginning, openSyllable, singleConsonantsEnding);
LetterPack blendingDemo = LetterPack("Blending Demo", LetterSet("Bl",  ["beginning"], ["bl"]), LetterSet("e", ["middle"], ["E"]), LetterSet("Nd", ["beginning"], ["nd"]));
  
List<LetterPack> defaultPacks = [standardClosed, standardOpen, blendingDemo];
List<LetterPack> allPacks = [standardClosed, standardOpen, blendingDemo];

var letterPackMap = {"Standard (Closed Syllable)": standardClosed, "Standard (Open Syllable)": standardOpen, "Blending Demo": blendingDemo};
String letterPackName = "";

LetterSet selectedBeginningSet;
LetterSet selectedMiddleSet;
LetterSet selectedEndSet;


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blending Board',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Blending Board'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
    ]);
    readAll();
  }

  Future<List> _read(String keyNumberString, List<String> listAddress) async {
    //allPacks.add(LetterPack("askdhf", LetterSet("hi",  ["beginning"], ["hi"]), LetterSet("x", ["middle"], ["X"]), LetterSet("yz", ["beginning"], ["YZ"])));
    final prefs = await SharedPreferences.getInstance();
    final key = keyNumberString;
    final value = prefs.getStringList(key) ?? [];
    listAddress = value;
    //print('read: $value');
    return value;
  }

  Future <int>_readInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return int
    int intValue = prefs.getInt(key);
    return intValue;
  }

  void readAll() async {
        await _readInt("numberOfKeys").then((value) {
              numberOfLetterPacks = value;
        });
        print(numberOfLetterPacks);
        if (numberOfLetterPacks == null){
          setState(() { 
            numberOfLetterPacks = 3;
          });        
          print("First time. Default packs will be set");
        }
        else{
          numberOfLetterPacks = numberOfLetterPacks;
          allPacks.clear();
          
          for(int i = 0; i<numberOfLetterPacks; i++){
            List<String> tempStringList;
            await _read("$i",tempStringList).then((value) {
              LetterPack tempPack = LetterPack.decodeLetterPack(value);
              allPacks.add(tempPack);
              letterPackMap[value[0]] = tempPack;
            });
            
          }
          print("Read and decoded all packs");
        }
        print(numberOfLetterPacks);
        /*for (LetterPack p in allPacks){
          p.letterPackInfo();
        }*/
      }
      Future <String>_readLetterPackName(String key) async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            //Return int
            String stringValue = prefs.getString(key);
            return stringValue;
      }
  
  _reset() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear(); 
     // allPacks.clear();  
        print("CLEARED ALL");
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            child: miscButtonRow(),
            alignment: Alignment.bottomCenter,
          ),
          Align(
            child: mainButtonRow(),
            alignment: Alignment.center,
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                _reset();
              },
              child: Icon(Icons.restore),
              backgroundColor: Colors.blueAccent,
              mini: true,
            ),
          )
        ],
      )

    );
  }
  Widget mainButtonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          createDeckButton(),
          logoButton(),
          myDecksButton(),
        ],
    )
   );
  }
  Widget miscButtonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
        children: [
          missionStatementButton(),
          settingsButton(),
        ],
    )
   );
  }
  Widget createDeckButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("Create Deck"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateDecksScreen()),
                  );
                  
          },
      ),
    );
  }
  Widget logoButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("logo"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: () async{
          //read
          await _readLetterPackName("currentLetterPackName").then((value) {
              if (value == null){
                print("First time, letterPackName = null");
                value = "Standard (Closed Syllable)";
              }
              letterPackName = value;
              print(letterPackName);
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BoardScreen()),
          );
          },
      ),
    );
  }
  Widget myDecksButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("My Decks"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyDecksScreen()),
            );
                  
          },
      ),
    );
  }
  Widget missionStatementButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: IconButton(
        icon: Icon(Icons.pie_chart),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MissionStatementScreen()),
          );
        },
      ),
    );
  }
  Widget settingsButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          
        },
      ),
    );
  }
  Widget qrButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: IconButton(
        icon: Icon(Icons.camera),
        onPressed: () {
          //go to QR camera
        },
      ),
    );
  }
}
class MissionStatementScreen extends StatefulWidget {
  @override
  _MissionStatementScreenState createState() => _MissionStatementScreenState();
}
class _MissionStatementScreenState extends State<MissionStatementScreen>{
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text("IMAGE"),
            //add hyperlink
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text("MISSION STATEMENT"),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.cancel),
              backgroundColor: Colors.blueAccent,
              mini: true,
            ),
          )
        ],
      )
      
    );
  }
}
class CreateDecksScreen extends StatefulWidget {
  @override
  _CreateDecksScreenState createState() => _CreateDecksScreenState();
}

class _CreateDecksScreenState extends State<CreateDecksScreen>{
  int _defaultBeginningChoiceIndex = 0;
  int _defaultMiddleChoiceIndex = 0;
  int _defaultEndChoiceIndex = 0;
  List <ChoiceChip> choiceChipList = [];
  List <LetterSet> beginningSetsList = [];
  List <LetterSet> middleSetsList = [];
  List <LetterSet> endSetsList = [];
  
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
    ]);
    //go through all the sets, take the ones that are beginning, and put them into a list
    for(int i = 0; i<allSets.length; i++){
     
     for(int j = 0; j<allSets[i].position.length; j++){
       if(allSets[i].position[j] == "beginning"){
        beginningSetsList.add(allSets[i]);
       } 
       if (allSets[i].position[j] == "middle"){
         middleSetsList.add(allSets[i]);
       }
       if (allSets[i].position[j] == "end"){
         endSetsList.add(allSets[i]);
       }
     }
    }
   }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: choiceChipRow(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Icon(Icons.home),
              backgroundColor: Colors.blueAccent,
              mini: true,
            ),
          )
        ],
      )
      
    );
  }
  
          
  Widget beginningChoiceChips() {
    return Expanded(
      child: ListView.builder(
        itemCount: beginningSetsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(beginningSetsList[index].name),
            selected: _defaultBeginningChoiceIndex == index,
            selectedColor: Colors.green,
            onSelected: (bool selected) {
              setState(() {
                _defaultBeginningChoiceIndex = selected ? index : null;
              });
            },
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
  Widget middleChoiceChips() {
    return Expanded(
      child: ListView.builder(
        itemCount: middleSetsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(middleSetsList[index].name),
            selected: _defaultMiddleChoiceIndex == index,
            selectedColor: Colors.green,
            onSelected: (bool selected) {
              setState(() {
                _defaultMiddleChoiceIndex = selected ? index : null;
              });
            },
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
  Widget endChoiceChips() {
    return Expanded(
      child: ListView.builder(
        itemCount: endSetsList.length,
        itemBuilder: (BuildContext context, int index) {
          return ChoiceChip(
            label: Text(endSetsList[index].name),
            selected: _defaultEndChoiceIndex == index,
            selectedColor: Colors.green,
            onSelected: (bool selected) {
              setState(() {
                _defaultEndChoiceIndex = selected ? index : null;
              });
            },
            backgroundColor: Colors.blue,
            labelStyle: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }
  Widget checkmarkButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: IconButton(
          icon: Icon(Icons.check),
          tooltip: '',
          onPressed: () {
            setState(() {
              selectedBeginningSet = beginningSetsList[_defaultBeginningChoiceIndex];
              selectedMiddleSet = middleSetsList[_defaultMiddleChoiceIndex];
              selectedEndSet = endSetsList[_defaultEndChoiceIndex];
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SaveScreen()),
              );
            });
          },
        ),
    );
  }
  Widget choiceChipRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          beginningChoiceChips(),
          middleChoiceChips(),
          endChoiceChips(),
          checkmarkButton(),
        ],
    )
   );
  }
  
}


class MyDecksScreen extends StatefulWidget {
  @override
  _MyDecksScreenState createState() => _MyDecksScreenState();
}

class _MyDecksScreenState extends State<MyDecksScreen> {
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      body: Stack(
          children: [
            GridView.count(
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 3,
              childAspectRatio: (itemWidth / itemHeight),
              // Generate 100 widgets that display their index in the List.
              children: List.generate(allPacks.length, (index) {
                return Container(
                  margin: EdgeInsets.all(20),
                  child: FlatButton(
                    child: Text(allPacks[index].name),
                    color: Colors.blue,
                    textColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                    onPressed: (){
                      letterPackName = allPacks[index].name;
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BoardScreen()),
                      );
                    },
                  ),
                );
              }),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp()),
                  );
                },
                child: Icon(Icons.home),
                backgroundColor: Colors.blueAccent,
                mini: true,
              ),
            )    
          ],
        )

    );
  }
    Widget standardClosedButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("Standard Closed"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          letterPackName = "Standard Closed";
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoardScreen()),
                  );
          },
      ),
    );
  }
  Widget standardOpenButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("Standard Open"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          letterPackName = "Standard Open";
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoardScreen()),
                  );
          },
      ),
    );
  }
  Widget blendingDemoButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("Blending Demo"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          letterPackName = "Blending Demo";
          Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoardScreen()),
          );
        },
      ),
    );
  }
  Widget buttonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          standardClosedButton(),
          standardOpenButton(),
          blendingDemoButton(),
        ],
    )
   );
  }
}

class SaveScreen extends StatefulWidget {
  @override
  _SaveScreenState createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final _controller = TextEditingController();
  
  _saveInt(int numValue) async {
        final prefs = await SharedPreferences.getInstance();
        final key = "numberOfKeys";
        final value = numValue;
        prefs.setInt(key, value);
        //print('saved $value');
  }
  _saveLetterPack(List<String> stringList, String keyName) async {
        LetterPack.encodeAll();
        final prefs = await SharedPreferences.getInstance();
        final key = keyName;
        final value = stringList;
        prefs.setStringList(key, value);
        //print('saved $value');
  }
  _saveAll() async {
        numberOfLetterPacks++;
        LetterPack.encodeAll();
        print("encode all success!");
        await _saveInt(numberOfLetterPacks);
        print("saveInt success!");
        for(int i=0; i<numberOfLetterPacks; i++){
          await _saveLetterPack(allData[i], i.toString());
        }
        print('Saved All');
        print(numberOfLetterPacks);
  }
  @override
  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
    ]);
  }
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
       
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            saveButton(),
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            
          ],
        ),
      ),

    );
  }
  
  Widget saveButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text("Save"),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          setState(() {
            allPacks.add(new LetterPack(_controller.text, selectedBeginningSet, selectedMiddleSet, selectedEndSet));
            letterPackName = _controller.text;
            //put new letterPack into letterPackMap
            letterPackMap[allPacks.last.name] = allPacks.last;
            _saveAll();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BoardScreen()),
          );
          }); 
        },
      ),
    );
  }
}

class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;
  String beginningCardName = letterPackMap[letterPackName].beginning.letters[0];
  String middleCardName = letterPackMap[letterPackName].middle.letters[0];
  String endCardName = letterPackMap[letterPackName].end.letters[0];
  
  _saveLetterPackName(String stringValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key = "currentLetterPackName";
    final value = stringValue;
    prefs.setString(key, value);
    //print('saved $value');
  }

  @override
  void initState(){
    super.initState();
    //save current letter pack name
    _saveLetterPackName(letterPackName);
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
    ]);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: cardButtonRow(),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Icon(Icons.home),
              backgroundColor: Colors.blueAccent,
              mini: true,
            ),
          ) 
        ],
      )
    );
  }
  
  Widget beginningCardButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text(beginningCardName),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          setState(() {
            counter1++;
            if(counter1 >= letterPackMap[letterPackName].beginning.letters.length){
              counter1 = 0;
            }
            beginningCardName = letterPackMap[letterPackName].beginning.letters[counter1];
          });
          
          },
      ),
    );
  }
  Widget middleCardButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text(middleCardName),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          setState(() {
            counter2++;
            if(counter2 >= letterPackMap[letterPackName].middle.letters.length){
              counter2 = 0;
            }
            middleCardName = letterPackMap[letterPackName].middle.letters[counter2];
          });
          
          },
      ),
    );
  }
  Widget endCardButton() {
    return Container(
      margin: EdgeInsets.all(20),
      child: FlatButton(
        child: Text(endCardName),
        color: Colors.blue,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
        onPressed: (){
          setState(() {
            counter3++;
            if(counter3 >= letterPackMap[letterPackName].end.letters.length){
              counter3 = 0;
            }
            endCardName = letterPackMap[letterPackName].end.letters[counter3];
          });
          
          },
      ),
    );
  }
  Widget cardButtonRow(){
    return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          beginningCardButton(),
          middleCardButton(),
          endCardButton(),
        ],
    )
   );
  }

}
