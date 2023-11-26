//  Load user prefences from the settings file
boolean drawMemory=false;

void loadSettings() {
    if (dataFile(cheminDeLApplication+"\\data\\system\\user-preferences.xml").isFile()) {
      XML xmlFile = loadXML(cheminDeLApplication+"\\data\\system\\user-preferences.xml");
    // Check if file exists


  

      // Interface scale
      XML entry = xmlFile.getChild("interface-scale");
      try {
        int value = entry.getInt("percentage", 100);
       println("Value"+ value);
        
      } catch (Exception e) {
        println("Unable to parse user settings - <interface-scale>:\n" + e);
      }

      // Colour scheme
      entry = xmlFile.getChild("color-scheme");
      try {
        int value = entry.getInt("id", 2);
         println("color schem" + value);
         loadColorScheme(value);
      } catch (Exception e) {
        println("Unable to parse user settings - <color-scheme>:\n" + e);
      }

      // Toggle FPS indicator on/off
      entry = xmlFile.getChild("memory-indicator");
      try {
        int value = entry.getInt("visible", 0);
        if (value <= 1 && value >= 0) {
          if (value == 1) drawMemory = true;
          else drawMemory = false;
        }
      } catch (Exception e) {
        println("Unable to parse user settings - <memory-indicator>:\n" + e);
      }

    //  // Toggle usage instructions on/off
    //  entry = xmlFile.getChild("usage-instructions");
    //  try {
    //    int value = entry.getInt("visible", 1);
    //    if (value == value && value <= 1 && value >= 0) {
    //      if (value == 1) showInstructions = true;
    //      else showInstructions = false;
    //      redrawUI = true;
    //      redrawContent = true;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <usage-instructions>\n" + e);
    //  }

    //  // Toggle usage saveOnlyEvents                                                                                ///////////////ERM
    //  entry = xmlFile.getChild("save-OnlyEvents");                                                                        ///////////////ERM
    //  try {
    //    int value = entry.getInt("state", 1);
    //    if (value == value && value <= 1 && value >= 0) {
    //      if (value == 1) saveOnlyEvents = true;
    //      else saveOnlyEvents = false;
    //      redrawUI = true;
    //      redrawContent = true;
    //    }
    //  } catch (Exception e) {  
    //    println("Unable to parse user settings - <saveOnlyEvents>\n" + e);
    //  }                                                                                                                ///////////////ERM
      
    // // Toggle saveTimestamp                                                                                            ///////////////ERM
    //  entry = xmlFile.getChild("save-Timestamp");                                                                        ///////////////ERM
    //  try {
    //    int value = entry.getInt("state", 1);
    //    if (value == value && value <= 1 && value >= 0) {
    //      if (value == 1) saveTimestamp = true;
    //      else saveTimestamp = false;
    //      redrawUI = true;
    //      redrawContent = true;
    //    }
    //  } catch (Exception e) {  
    //    println("Unable to parse user settings - <saveTimestamp>\n" + e);
    //  }                                                                                                                    ///////////////ERM

    //  // Get serial port settings
    //  entry = xmlFile.getChild("serial-port");
    //  try {
    //    int value = entry.getInt("baud-rate", 115200);
    //    for (int i = 0; i < baudRateList.length; i++) {
    //      if (baudRateList[i] == value) baudRate = value;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <serial-port: baud-rate>\n" + e);
    //  }

    //  try {
    //    String value = entry.getString("line-ending", str('\n'));
    //    char charValue = value.charAt(0);
    //    for (int i = 0; i < lineEndingList.length; i++) {
    //      if (lineEndingList[i] == charValue) lineEnding = charValue;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <serial-port: line-ending>\n" + e);
    //  }

    //  try {
    //    String value = entry.getString("parity", str('N'));
    //    char charValue = value.charAt(0);
    //    for (int i = 0; i < parityBitsList.length; i++) {
    //      if (parityBitsList[i] == charValue) serialParity = charValue;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <serial-port: parity>\n" + e);
    //  }

    //  try {
    //    int value = entry.getInt("databits", 8);
    //    for (int i = 0; i < dataBitsList.length; i++) {
    //      if (dataBitsList[i] == value) serialDatabits = value;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <serial-port: databits>\n" + e);
    //  }

    //  try {
    //    float value = entry.getFloat("stopbits", 1.0);
    //    for (int i = 0; i < stopBitsList.length; i++) {
    //      if (stopBitsList[i] == value) serialStopbits = value;
    //    }
    //  } catch (Exception e) {
    //    println("Unable to parse user settings - <serial-port: stopbits>\n" + e);
    //  }
    }
  }
