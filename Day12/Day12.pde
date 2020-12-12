String[] inp;
void setup() {
  inp = loadStrings("input.txt");
  println(interprete(inp));
}


int interprete(String[] inp) {
  int x =0;
  int y = 0; 
  int heading = 90; // N = 0, E = 90

  for (String q : inp) {
    char ins = q.charAt(0);
    int amount = Integer.parseInt(q.substring(1));

    if (ins == 'N') {
      x+=amount;
    }
    if (ins == 'S') {
      x-=amount;
    }

    if (ins == 'E') {
      y+=amount;
    }
    if (ins == 'W') {
      y-=amount;
    }

    if (ins == 'R') {
      heading+=amount;
    }
    if (ins == 'L') {
      heading-=amount;
    }
    if (heading >= 360) {
      heading-=360;
    }
    if (heading <= 0) {
      heading+=360;
    }

    if (ins == 'F') {
      if (heading == 0) {
        x+=amount;
      }
      if (heading == 90) {
        y+=amount;
      }
      if (heading == 180) {
        x-=amount;
      }
      if (heading == 270) {
        y-=amount;
      }
      if (heading == 360) {
        x+=amount;
      }
    }
    //println(y, x, heading);
  }
  return abs(x)+abs(y);
}
