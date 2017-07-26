int getInflowOutflow() {
  // Declare outflow and inflow string variables
  String inflow = "";
  String outflow = "";
  
  // Load data from url into an array of strings
  String dataUrl = "http://www.spk-wc.usace.army.mil/fcgi-bin/hourly.py?report=pnf&textonly=true";
  String[] rawtext = loadStrings(dataUrl);
  
  // Loop through array to find latest available data
  // Then split the tokens, loop through and find first non-NR values for both outflow(index=5) and inflow(index=6)
  for (int i = 55; i > 7; i--) {
    String[] str = splitTokens(rawtext[i]);
    if ((!str[5].equals("-NR-")) && (!str[6].equals("-NR-"))) {
      outflow = str[5];
      inflow = str[6];
      //println("outflow: " + outflow + " inflow: " + inflow);
      i = 7;
    }
  } 
  
  // Outflow and inflow strings to int value
  int out = Integer.parseInt(outflow);
  int in = Integer.parseInt(inflow);
  
  return out - in;
}