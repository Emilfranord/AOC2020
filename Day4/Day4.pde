String[] inp;

void setup() {

  inp = loadStrings("input.txt");

  String[] clean =  cleanInput(inp);


  for (String q : clean) {
    //println(q);
    //println("final count: "+alsoValidData(q));
  }

  //println(clean.length);
  //println(amountValid(clean));
  println("final count part 2: " +amountValidTwo(clean));
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

int amountValidTwo(String[] p) {
  int count = 0;

  for (String q : p) {
    if (alsoValidData(q)) {
      count++;
    }
  }

  return count;
}


boolean alsoValidData(String p) {
  int count = 0;
  if (p.contains("iyr")) { //<>//
    int index = p.indexOf("iyr:")+4;

    String sub = p.substring(index, index+4);
    //println(sub);
    int year = Integer.parseInt(sub);

    if (year>= 2010 && year<=2020) {
      count++;
      print("iyr, ");
    }
  }

  if (p.contains("byr")) { //<>//
    int index = p.indexOf("byr:")+4;

    String sub = p.substring(index, index+4);

    int year = Integer.parseInt(sub);

    if (year>= 1920 && year<=2002) {
      count++;
      print("byr, ");
    }
  }

  if (p.contains("eyr")) { //<>//
    int index = p.indexOf("eyr:")+4;

    String sub = p.substring(index, index+4);

    int year = Integer.parseInt(sub);

    if (year>= 2020 && year<=2030) {
      count++;
      print("eyr, ");
    }
  }
  if (p.contains("hgt")) { //<>//
    int index = p.indexOf("hgt:")+4;
    int hei = 0;

    // inches
    {
      if (p.contains("in")) {

        int unitIndex = p.indexOf("in");
        if ((unitIndex-index )<=2 &&(unitIndex-index )>=1) {
          String sub = p.substring(index, unitIndex);

          hei = Integer.parseInt(sub);

          if (hei>= 59 && hei<=76) {
            count++;
            print("hgtIN, ");
          }
        }
      }
    }
    // cencimeter
    {
      if (p.contains("cm")) { //<>//
        int unitIndex = p.indexOf("cm");

        if ((unitIndex-index )<=3 &&(unitIndex-index )>=1 ) {
          String sub = p.substring(index, unitIndex);

          hei = Integer.parseInt(sub);
          if (hei>=150 && hei<=193) {
            count++;
            print("hgtCM, ");
          }
        }
      }
    }
  }
  if (p.contains("hcl")) { //<>//
    String numbers = "123456789abcdef";

    int index = p.indexOf("hcl:")+4;
    if (p.charAt(index) != '#') {
      count--;
    }

    if (p.length()>=index+7) {
      for (int i = index+1; i<index+7; i++) {
        if (!numbers.contains(p.substring(i, i+1))) {
          count--;
          print("-");
        }
      }
    } else {
      count--;
    }
    count ++;
    print("hcl, ");
  }

  if (p.contains("ecl")) { //<>//
    String[] validECL = {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"};

    for (String q : validECL) {
      if (p.contains(q)) {
        count++;
        print("ecl, ");
        break;
      }
    }
  }

  if (p.contains("pid")) { //<>//
    String numbers = "123456789";

    int index = p.indexOf("pid:")+4;
    if (p.length()>=index+10) {
      for (int i = index; i<index+10; i++) {
        if (!numbers.contains(p.substring(i, i))) {
          count--;
        }
      }
    } else {
      count--;
    }
    count ++;
    print("pid, ");
  }

  if (p.contains("cid")) { //<>//
  } // to cheat and give us acces we ignore cid.

  println(count); //<>//
  return count == 7;
}
