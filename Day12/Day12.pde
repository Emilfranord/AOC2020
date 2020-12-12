String[] inp;
void setup() {
  inp = loadStrings("input.txt");
  println(interprete(inp));
  println(interpreteWaypoint(inp));
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






int interpreteWaypoint(String[] inp) {
  int x =0;
  int y = 0; 
  int heading = 90; // N = 0, E = 90

  int wx = 1;
  int wy = 10;

  for (String q : inp) {
    char ins = q.charAt(0);
    int amount = Integer.parseInt(q.substring(1));

    if (ins == 'N') {
      wx+=amount;
    }
    if (ins == 'S') {
      wx-=amount;
    }

    if (ins == 'E') {
      wy+=amount;
    }
    if (ins == 'W') {
      wy-=amount;
    }

    if (ins == 'R') {
      PVector temp = new PVector(wx, wy);
      temp.rotate(amount * 0.0174533);
      wx =round( temp.x);
      wy = round( temp.y);
    }
    if (ins == 'L') {
      PVector temp = new PVector(wx, wy);
      temp.rotate(-amount * 0.0174533);
      wx = round( temp.x);
      wy =  round( temp.y);
    }

    //if (heading >= 360) {
    //  heading-=360;
    //}
    //if (heading <= 0) {
    //  heading+=360;
    //}

    if (ins == 'F') {
      for (int i = 0; i<amount; i++) {
        x+= wx; 
        y+= wy;
      }
    }
    println(y, x, wy, wx);
  }
  return abs(x)+abs(y);
}
