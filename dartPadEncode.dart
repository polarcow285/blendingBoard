List<String> dataStringList = [];

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
  
  
}
LetterSet singleConsonantsBeginning = new LetterSet("Single Consonants", ["beginning"], ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p ", "qu", "r", "s", "t", "v", "w", "x", "y", "z"]);  
LetterSet singleConsonantsEnding = new LetterSet("Single Consonants",["end"], ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p ", "r", "s", "t", "v", "w", "x", "y", "z"]);
LetterSet hBrothers = LetterSet("H Brothers", ["sides"], ["ch", "ph", "sh", "th", "wh"]);
LetterSet beginningBlends = LetterSet("Beginning Blends", ["beginning"], ["bl", "br", "cl", "cr", "dr", "fl", "fr", "gl", "gr", "pl", "pr", "sc", "scr", "shr", "sk", "sl", "sm", "sn", "sp", "spl", "spr", "squ", "st", "str", "sw", "thr", "tr", "tw"]);
LetterSet shortVowelPointers = LetterSet("Short Vowel Pointers", ["middle", "end"], ["ck", "dge", "tch", "ff", "ll", "ss", "zz"]);
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


void main() {
  List <List> allData = [];

  for (int i=0; i<allPacks.length; i++){
    List <String> temp = [];
    allPacks[i].dataEncode(temp);
    allData.add(temp);
  }
  print(allData);
  
  
  
 
  
}
