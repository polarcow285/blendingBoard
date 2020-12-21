import 'package:flutter/material.dart';
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
      title: 'Flutter Demo',
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Saving data'),
          ),
          body: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Read'),
                  onPressed: () {
                    //_read("something");
                   // setState(() { 
                     //numberOfLetterPacks = 4;
                   // }); 
                  
                    readAll();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Save'),
                  onPressed: () {
                    _saveAll();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('Add letterpack'),
                  onPressed: () {
                    setState(() { 
                      _addLetterPack();
                    });
                    
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('add letterpack2'),
                  onPressed: () {
                    _addLetterPack2();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('reset'),
                  onPressed: () {
                    _reset();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RaisedButton(
                  child: Text('all letter packs'),
                  onPressed: () {
                    for (LetterPack p in allPacks){
                      p.letterPackInfo();
                    }
                  },
                ),
              ),
              
            ],
          ),
        );
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

      _saveInt(int numKey) async {
        final prefs = await SharedPreferences.getInstance();
        final key = "numberOfKeys";
        final value = numKey;
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
              allPacks.add(LetterPack.decodeLetterPack(value));
            });
            
          }
          print("Read and decoded all packs");
        }
        print(numberOfLetterPacks);
        /*for (LetterPack p in allPacks){
          p.letterPackInfo();
        }*/
      }
      

      void _addLetterPack() {
 
        allPacks.add(LetterPack("askdhf", LetterSet("hi",  ["beginning"], ["hi"]), LetterSet("x", ["middle"], ["X"]), LetterSet("yz", ["beginning"], ["YZ"])));
        print(numberOfLetterPacks);
        numberOfLetterPacks++;
        print("added letter pack");   
     
        //numberOfLetterPacks = 3;
        
      }

      _addLetterPack2()  {
        allPacks.add(LetterPack("HIII", LetterSet("ALSKDJFH",  ["beginning"], ["923892"]), LetterSet("XYZ", ["middle"], ["XYZ"]), LetterSet("ySDKJFSDJz", ["beginning"], ["YISIDSJDZ"])));
        numberOfLetterPacks++;
        print("added letter pack222222");
     }
     _reset() async{
      SharedPreferences preferences = await SharedPreferences.getInstance();
await preferences.clear(); 
     // allPacks.clear();  
        print("CLEARED ALL");
     }
}
