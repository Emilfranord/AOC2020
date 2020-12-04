String[] inp;

void setup() {

  inp = loadStrings("input.txt");

  String[] clean =  cleanInput(inp);


  for (String q : clean) {
    println(q);
    alsoValidData(q);
  }

  //println(clean.length);
  //println(amountValid(clean));
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

boolean isValid(String p) {
  int count =0;

  if (p.contains("iyr")) {
    count++;
  }
  if (p.contains("byr")) {
    count++;
  }
  if (p.contains("eyr")) {
    count++;
  }
  if (p.contains("hgt")) {
    count++;
  }
  if (p.contains("hcl")) {
    count++;
  }
  if (p.contains("ecl")) {
    count++;
  }
  if (p.contains("pid")) {
    count++;
  }
  if (p.contains("cid")) {
  } // to cheat and give us acces we ignore cid.

  return count == 7;
}

int amountValid(String[] p) {
  int count = 0;

  for (String q : p) {
    if (isValid(q)) {
      count++;
    }
  }

  return count;
}


boolean alsoValidData(String p) {
  int count =0;

  if (p.contains("iyr")) {
    int index = p.indexOf("iyr:")+4;

    String sub = p.substring(index, index+4);
    println(sub);
    int year = Integer.parseInt(sub);

    if (year>= 2010 && year<=2020) {
      println("added");
      count++;
    }
  }

  if (p.contains("byr")) {
    int index = p.indexOf("byr:")+4;

    String sub = p.substring(index, index+4);

    int year = Integer.parseInt(sub);

    if (year>= 1920 && year<=2002) {
      count++;
    }
  }

  if (p.contains("eyr")) {
    int index = p.indexOf("eyr:")+4;

    String sub = p.substring(index, index+4);

    int year = Integer.parseInt(sub);

    if (year>= 2020 && year<=2030) {
      count++;
    }
  }
  if (p.contains("hgt")) {
    // TODO: implement this 
  }
  if (p.contains("hcl")) {
    // TODO: implement this
  }
  if (p.contains("ecl")) {
    // TODO: implement this
  }
  if (p.contains("pid")) {
    // TODO: implement this
  }
  if (p.contains("cid")) {
  } // to cheat and give us acces we ignore cid.

  return count == 7;
}
