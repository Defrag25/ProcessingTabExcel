import processing.serial.*;
Serial port;
ScrollableList portsList;


void GUISerial(){
  
}

////Zion Connect Lib
//import processing.serial.*;
//Serial Zport;
//String[] comList;
//int portNum;
//int posLine = 90;
////Textarea statusArea;
//boolean selected = false, firstScan = false;
//boolean ZionEncoderConnected=false;
//Textfield EinputField;
//Button EClearOutput, connectButton, disconnectButton;
//Button bpOnglet1,bpOnglet2,bpOnglet3,bpOnglet4;
//Textarea EoutputArea;
//ScrollableList portsList;
//Toggle ShowAll, ShowCoordAxes;
//Textlabel ShowAllLabel,ShowAxesLabel;
//int OngletSelected=1;
//Textlabel lportsList;


//void GUI_refresh(){
//  //GUI_VIEW_Refresh();
//  //PosRefresh();
////   cp5.get(Textarea.class,"statusArea")
////                  .setPosition(5,  height-25)
////                  .setSize( width-10, 20)
////       //.updateSize()
////       ;
//}




//void GUI_CONNECT() {
//    ControlFont font   = new ControlFont(createFont("Arial", 16, true));
//    ControlFont sfont  = new ControlFont(createFont("consolas", 12));


//  //cp5.addTab("CONNECT")
//  //   .setColorBackground(color(0, 160, 100))
//  //   .setColorLabel(color(255))
//  //   .setColorActive(color(255, 128, 0)) 
//  //   .activateEvent(true);
  
   
    
// EoutputArea = cp5.addTextarea("serialOutput")
//    .setPosition(2, 35)
//    .setSize(495, 425)
//    .setFont(sfont)
//    .setLineHeight(14)
//    .setColor(#FFFFFF)
//    .setColorBackground(#444444)
//    .setScrollBackground(#222222)
//    .scroll(1)
//    .showScrollbar()
//    .moveTo("CONNECT");



//  //COM port selection
//  lportsList    = cp5.addTextlabel("lportsList") .setText("Port Comm ENCODEURS") .setPosition( 2,500).setColorValue(#00FF00).setFont(font).moveTo("CONNECT");

//  comList = Serial.list();  
//  portsList = cp5.addScrollableList("portsList")
//    //portsList = cp5.addScrollableList(comList.toString())
//    .setPosition(2, 520)
//    .setSize(190, 100)
//    .setBarHeight(25)
//    .setItemHeight(25)
//    .setItems(comList)
//    .setLabel(" COM ports")
//    .setBroadcast(true)
//    .moveTo("CONNECT")
//    .close()
//    .bringToFront();
 
//// ONGLETS /////////
//  bpOnglet1 = cp5.addButton("BPONGLETS1")  .setPosition(  0, 15)    .setSize(90, 20) .setColorBackground(#008000)  .setFont(sfont)  .setLabel("ENCODER")    .moveTo("CONNECT");
//  bpOnglet2 = cp5.addButton("BPONGLETS2")  .setPosition( 90, 15)    .setSize(90, 20) .setColorBackground(#000080)  .setFont(sfont)  .setLabel("PENDANT")    .moveTo("CONNECT");
//  bpOnglet3 = cp5.addButton("BPONGLETS3")  .setPosition(180, 15)    .setSize(90, 20) .setColorBackground(#000080)  .setFont(sfont)  .setLabel("3")    .moveTo("CONNECT");
//  bpOnglet4 = cp5.addButton("BPONGLETS4")  .setPosition(270, 15)    .setSize(90, 20) .setColorBackground(#000080)  .setFont(sfont)  .setLabel("4")    .moveTo("CONNECT");

////controlP5.setColorBackground( color( 255,0,0 ) );
//// setColorForeground
//// setColorActive
//// setColorLabel
//// setColorValue

//  //COM port connect
//  connectButton = cp5.addButton("connectButton")  .setPosition(200, 520)    .setSize(90, 20)    .setLabel("connect")    .moveTo("CONNECT");

//  //COM port disconnect
//  disconnectButton = cp5.addButton("disconnectButton")    .setPosition(320, 520)    .setSize(120, 20)    .setLabel("disconnect")    .moveTo("CONNECT")    .hide();

//  ShowAll=cp5.addToggle("ShowAll")    .setPosition(530, 65)    .setSize(50, 20)    .setValue(false)    .setLabel("")    .setMode(ControlP5.SWITCH)    .moveTo("CONNECT");
//  ShowAllLabel=cp5.addTextlabel("ShowAllLabel").setText("All").setPosition(580, 65).setColorValue(#00FF00).setFont(font).moveTo("CONNECT");

//  ShowCoordAxes=cp5.addToggle("ShowCoordAxes")    .setPosition(530, 90)    .setSize(50, 20)    .setValue(false)    .setLabel("")    .setMode(ControlP5.SWITCH)    .moveTo("CONNECT");
   
// ShowAxesLabel=cp5.addTextlabel("ShowAxesLabel").setText("AXES").setPosition(580, 90).setColorValue(#00FF00).setFont(font) .moveTo("CONNECT");

//  //serial input
//  EinputField  = cp5.addTextfield("EinputField").setPosition(2, 465).setSize(445, 30).setAutoClear(true).setLabel("").setFocus(true).moveTo("CONNECT").hide();
//  EClearOutput = cp5.addButton("EClearOutput").setPosition(450, 465).setSize(45, 30).setLabel("Clear").setBroadcast(true).setFont(sfont).moveTo("CONNECT").hide();


// output(8,"Selectionner le port Comm ENCODEUR pour synchroniser la position du robot avec les axes");
// output(8,"puis faire le reset des axes du robot avec le pendant");
// output(8,"puis cliquer sur >0<");
//   DisplayViewModes("CONNECT");
//}

//void EClearOutput() {
//  EoutputArea.clear();
//}
//void OngletChange(){  
//  switch (OngletSelected)
//  {
//    case 1 :{ 
//    EoutputArea.show();
//    EClearOutput.show();
//    EinputField.show();
//    PoutputArea.hide();
//    PClearOutput.hide();
//    PinputField.hide();
//    bpOnglet1 .setColorBackground(#444444);//#008000);
//    bpOnglet2 .setColorBackground(#000080);
//    bpOnglet3 .setColorBackground(#000080);
//    bpOnglet4 .setColorBackground(#000080);
    
//     break;}
//    case 2 :{ 
//    EoutputArea.hide();
//    EClearOutput.hide();
//    EinputField.hide();
//    PoutputArea.show();
//    PClearOutput.show();
//    PinputField.show();
//    bpOnglet1 .setColorBackground(#000080);
//    bpOnglet2 .setColorBackground(#444444);
//    bpOnglet3 .setColorBackground(#000080);
//    bpOnglet4 .setColorBackground(#000080);
    
//     break;}
//    case 3 :{ 
//    EoutputArea.hide();
//    EClearOutput.hide();
//    EinputField.hide();
//    PoutputArea.hide();
//    PClearOutput.hide();
//    PinputField.hide();
//    bpOnglet1 .setColorBackground(#000080);
//    bpOnglet2 .setColorBackground(#000080);
//    bpOnglet3 .setColorBackground(#444444);
//    bpOnglet4 .setColorBackground(#000080);
    
//     break;}
//    case 4 :{ 
//    EoutputArea.hide();
//    EClearOutput.hide();
//    EinputField.hide();
//    PoutputArea.hide();
//    PClearOutput.hide();
//    PinputField.hide();
//    bpOnglet1 .setColorBackground(#000080);
//    bpOnglet2 .setColorBackground(#000080);
//    bpOnglet3 .setColorBackground(#000080);
//    bpOnglet4 .setColorBackground(#444444);
    
//     break;}

//    default : break;
//  }
//  //
  
//}
//void BPONGLETS1(){ OngletSelected = 1;OngletChange();}
//void BPONGLETS2(){ OngletSelected = 2;OngletChange();}
//void BPONGLETS3(){ OngletSelected = 3;OngletChange();}
//void BPONGLETS4(){ OngletSelected = 4;OngletChange();}



//public void EinputField(String s){
//  if (s==""){return;}
//  if(ZionEncoderConnected) {
//    int len = s.length();
//    output(10,s.substring(0,len));
//    Zport.write(s.substring(0,len) + '\n');
//  }

//}
//public void serialOutput(String s) {
//  //tab size fix
//  Zport.write(s);
//}

//public void angleSlider(int angle) {
//  posLine = angle;
//}

//public void portsList(int n) {
//  selected = true;
//  portNum = n;
//}
 
//void importTextFile(String fileName) {
 
//}

//void GUI_ShowState(boolean State){
//  if (State)
//  { // Encodeur connectés
//   connectButton.hide();
//   disconnectButton.show();
//   portsList.show();
//   ShowAll.show();
//   ShowAllLabel.show();
//   ShowCoordAxes.show();
//   ShowAxesLabel.show();
//   //EClearOutput.show();
//   //serialInput.hide();
//   OngletChange(); //   outputArea.show();
//  }
//  else
//  { // Encodeur déconnectés
//   connectButton.show();
//   disconnectButton.hide();
//   portsList.show();
//   ShowAll.show();
//   ShowAllLabel.show();
//   ShowCoordAxes.show();
//   ShowAxesLabel.show();
//   //EClearOutput.show();
//   //serialInput.hide();
//   OngletChange(); //   outputArea.show();
//  }
//}

//void GUI_CONNECT_Refresh() {
// GUI_ShowState(ZionEncoderConnected);
// if (!ZionEncoderConnected)
//  {
//   comList = Serial.list();
//   portsList.setItems(comList);
//  }
//}

//void Zion_ConnectToSerial()
//{
//     if (selected) {
//      try {
//        configured=true;
//        ZionEncoderConnected=true;

//        Zport = new Serial(this, Serial.list()[portNum], 115200);

//        //timerStatus.start();
//        EClearOutput();
//        output(11, "Connected to " + Serial.list()[portNum]);            
//        GUI_refresh();
//        delay(250);

//       // cp5.getTab("default").bringToFront();
//      } 
//      catch(Exception e) {
//        output(11, "Unable to connect to " + Serial.list()[portNum]);
//        //output(11,  e.toString());


//        //timerStatus.stop();
//        GUI_refresh();
//      }
//    } else {
//      output(11, "Select appropriate COM port");
//    }
//    BPONGLETS1();
//}

//void Zion_DisconnectToSerial()
//{
//      configured=false; // configured=true; ///// 2023-ERM
//    ZionEncoderConnected=false;
//    output(11, "Disconnected from " + Serial.list()[portNum]);

//    Zport.stop();
//    //EClearOutput();
//    GUI_refresh();

//}

//void output(int code1, String s) {
//  //codes               0          1          2          3          4          5          6          7          8          9          10         11
//  String[] codes = {"       ", "[ECHO] ", "[SETUP]", "[TRACE]", "[PRG] ", "[KINE] ", "[ERROR]", "[WARN] ", "[INFO] ", "     > ", "[CMD]  ", "[APP]  "};
//  s=trim(s);
// if(s!=null){  
//   EoutputArea.append(codes[code1] + " " + " " + s + "\n");
// }
//}
