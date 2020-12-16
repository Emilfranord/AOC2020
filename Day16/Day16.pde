String[] inp;
String[] rul; 
ArrayList <Rule> ru = new ArrayList <Rule>();
ArrayList <Ticket> in = new ArrayList <Ticket>();
void setup() {
  inp = loadStrings("input.txt");
  rul = loadStrings("rules.txt");

  //Rule r = new Rule("departure location: 26-724 or 743-964");

  for (String q : rul) {
    ru.add(new Rule(q));
  }
  for (String q : inp) {
    in.add(new Ticket(q));
  }



  for (Rule r : ru) {
    for (Ticket t : in) {

      println(r.compTo(t));
    }
  }
}

//split the input in a good way
//  build a list of valid numbers
//  check on all tickets how they much they fail




class Rule {
  int[] bounds;

  Rule(String inp) {
    bounds = new int[4];
    String[] temp = inp.split(" ");
    String[] tempOne = temp[temp.length-1].split("-");
    String[] tempTwo = temp[temp.length-3].split("-");

    this.bounds[2] = Integer.parseInt(tempOne[0]);
    this.bounds[3] = Integer.parseInt(tempOne[1]);
    this.bounds[0] = Integer.parseInt(tempTwo[0]);
    this.bounds[1] = Integer.parseInt(tempTwo[1]);
  }

  int compTo(Ticket t) {
    int count = 0; 

    for (int q : t.values) {
      
      boolean validOnce = false;
      if ((q>=this.bounds[0] && q<=this.bounds[1]) || (q>=this.bounds[2] && q<=this.bounds[3])) {
        validOnce = true;
      }

      if (validOnce) {
        return 0;
      } else {
        return q;
      }
    } 
    //return count;
    return 0;
  }
}

class Ticket {
  int[] values;

  Ticket(String inp) {
    String[] temp = inp.split(",");
    values = new int[temp.length];

    for (int i = 0; i<temp.length; i++) {
      values[i]  = Integer.parseInt(temp[i]);
    }
    
    
  }
}
