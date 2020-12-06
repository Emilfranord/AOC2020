import java.util.Arrays;
String[] inp; 

void setup() {
  inp = loadStrings("input.txt");
  //inp = convert(inp);
  println("Part one: "+totalCountOne(inp));
  println("Part two: "+totalCountTwo(inp));
}

void draw() {
}

int totalCountOne(String[] inp) {
  int count =0;

  for (String q : inp) {
    count+= yesInGroup(q);
  }

  return count;
}

int yesInGroup(String inp) {
  char[] alphabet = "abcdefghijklmnopqrstuvwxyz".toCharArray(); // https://stackoverflow.com/questions/17575840/better-way-to-generate-array-of-all-letters-in-the-alphabet

  int count = 0; 

  for (char q : alphabet) {
    if (inp.indexOf(q) != -1) {
      count ++;
    }
  }
  return count;
}


String[] convert(String[] inp) {
  return cleanInput(inp);
}


int everyoneYes(String[] inp) { // gets the right input, does the wrong thing.
  char[] alphabet = "abcdefghijklmnopqrstuvwxyz".toCharArray();
  int count =0;
  for (char p : alphabet) {
    int charSeen = 0;
    for (String q : inp) {
      if(q.indexOf(p) != -1){charSeen++;}
    }
    if(charSeen == inp.length){count++;}
  }
  return count;
}


int totalCountTwo(String[] inp) {
  int count= 0;
  int startIndex = 0;

  for (int i = 0; i<inp.length; i++) {
    if (inp[i].length() == 0) {
      String[] temp = Arrays.copyOfRange(inp, startIndex, i);
      count+= everyoneYes(temp);
      startIndex = i+1;
    }
  }
  String[] temp = Arrays.copyOfRange(inp, startIndex, inp.length);
  count+= everyoneYes(temp);

  //printArray(temp);

  return count;
}

String[] cleanInput(String[] inp) {
  ArrayList<String> temp = new ArrayList<String>();

  String passportFragment = "";
  for (int i = 0; i<inp.length; i++ ) {
    if (inp[i].length() ==0) {
      // it is a break between passwords
      ;
      temp.add(passportFragment);
      passportFragment = "";
    } else {
      passportFragment += inp[i] + " ";
    }
  }
  // to get the last password in
  temp.add(passportFragment);
  passportFragment = "";

  String[] bar = new String[temp.size()];

  for (int i = 0; i<bar.length; i++) {
    bar[i] = temp.get(i);
  }

  return bar;
}
