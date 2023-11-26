import controlP5.*;

ScrollableList profileList;
Textarea stackArea;
Textarea stackArea2;
String[] files;
ControlP5 cp5;
float valeur1 = 5; // Nombre initial
float valeur2 = 10; // Nombre initial
float valeur3 = 20; // Nombre initial
float valeur4 = 28; // Nombre initial
float valeur5 = 16; // Nombre initial
float valeur6 = 25; // Nombre initial
float valeur7 = 25; // Nombre initial

boolean drawTable;
void GUI_Setup(){
createFilesListBox();  
  cp5 = new ControlP5(this);
  
  cp5.getTab("default")     .activateEvent(true)     .setLabel("my default tab")     .setId(1)     ;
  //cp5.getTab("Parameters")   .activateEvent(true)                              .setId(2)     ;
  PFont pfont = createFont("Arial", 25, true); // use true/false for smooth/no-smooth
  ControlFont Pfont = new ControlFont(pfont, 16);
 // ControlFont sfont = new ControlFont(createFont("consolas", 12));

   stackArea = cp5.addTextarea("Stack")
                  .setPosition(610, 240)
                  .setSize(600, 100)
                  .setFont(Pfont)
                  .setLineHeight(14)
                  .setColor(#FFFFFF)
                  .setColorBackground(#444444)
                  .setScrollBackground(#222222)
                  .scroll(1)
                  .showScrollbar()
                  .hide()
                  //.moveTo("Parameters") 
                  ;
   stackArea2= cp5.addTextarea("Stack2")
                  .setPosition(610, 245)
                  .setSize(600, 200)
                  .setFont(Pfont)
                  .setLineHeight(14)
                  .setColor(#FFFFFF)
                  .setColorBackground(#444444)
                  .setScrollBackground(#222222)
                  .scroll(1)
                  .showScrollbar()
                  .hide()
                  //.moveTo("Parameters") 
                  ;

  
  profileList = cp5.addScrollableList("profileList")
                  .setPosition(0, 30)
                  .setSize(200, 300)
                  .setBarHeight(25)
                  .setItemHeight(25)
                  .setItems(files)
                  .close()
                  //.moveTo("Parameters") 
                  .hide()
                  ;

//  cp5.addButton("save")  .setLabel("save")  .setPosition(210,0) .setSize(50,25).moveTo("Parameters") ; ; 
//  cp5.addButton("open")  .setLabel("Open")  .setPosition(210,30) .setSize(50,25).moveTo("Parameters") ; ; 
  cp5.addButton("exportline") .setLabel("export line") .setPosition(270,1).setSize(50,25);//.moveTo("Parameters") ; ;
  cp5.addButton("bpStart") .setLabel("START") .setPosition(330,0).setSize(50,25);//.moveTo("Parameters") ; ;
  cp5.addButton("bpStop") .setLabel("STOP")   .setPosition(330,25).setSize(50,25);//.moveTo("Parameters") ; ;
//  cp5.addButton("Add") .setLabel("Add")       .setPosition(390,0).setSize(50,25).moveTo("Parameters") ; ;
//  cp5.addButton("Remove") .setLabel("Remove") .setPosition(390,30).setSize(50,25).moveTo("Parameters") ; ;
 cp5.addButton("request") .setLabel("Request").setPosition(450,0).setSize(50,25);//.moveTo("Parameters") ;
 cp5.addButton("request2").setLabel("Request2").setPosition(450,25).setSize(50,25);//.moveTo("Parameters") ;
  cp5.addButton("color0") .setLabel("color0") .setPosition(510,0).setSize(50,25);//.moveTo("Parameters") ; ;
  cp5.addButton("color1") .setLabel("color1") .setPosition(570,0).setSize(50,25);//.moveTo("Parameters") ; ;
  cp5.addButton("color2") .setLabel("color2") .setPosition(630,0).setSize(50,25);//.moveTo("Parameters") ; ;
  cp5.addButton("color3") .setLabel("color3") .setPosition(690,0).setSize(50,25);//.moveTo("Parameters") ; ;
  //profileList.setValue(0);
   cp5.addSlider("valeur1") .setPosition(800, 50) .setRange(0, 100) .setValue(valeur1) .setLabel("leftBarWidth") .setSize(200, 20).hide();
   cp5.addSlider("valeur2") .setPosition(800, 75) .setRange(0, 100) .setValue(valeur2) .setLabel("cellLeftBarWidth" ) .setSize(200, 20);
   cp5.addSlider("valeur3") .setPosition(800,100) .setRange(0, 100) .setValue(valeur3) .setLabel("cellTopBarHeigth") .setSize(200, 20);
   cp5.addSlider("valeur4") .setPosition(800,125) .setRange(0, 100) .setValue(valeur4) .setLabel("startLeftCells") .setSize(200, 20);
   cp5.addSlider("valeur5") .setPosition(800,150) .setRange(0, 100) .setValue(valeur5) .setLabel("startTopCells" ) .setSize(200, 20);
   cp5.addSlider("valeur6") .setPosition(800,175) .setRange(0, 100) .setValue(valeur6) .setLabel("") .setSize(200, 20);
   cp5.addSlider("valeur7") .setPosition(800,200) .setRange(0, 100) .setValue(valeur7) .setLabel("") .setSize(200, 20);

  maPile = new Pile();
  id=1;
  cp5.getTab("default").bringToFront();
}

String removeExtension(String fileName) {
  int extensionIndex = fileName.lastIndexOf('.');
  if (extensionIndex != -1) {
    return fileName.substring(0, extensionIndex);
  }
  return fileName;
}


void bpStart(){ 
  for (cSheet sheet:Excel.sheet)
   {
    if ( (sheet.tSeqCreated==true))
     {
      if (sheet.isFocused()){ sheet.tSeq.start (sheet);}
     }
   }
 stackArea.clear();
}

void bpStop(){ 
  stackArea2.clear();
   
    for (cSheet sheet:Excel.sheet)
   {
   if (sheet.isFocused()){if ( (sheet.tSeqCreated==true)){sheet.tSeq.stop (sheet);}}
   }
}

void exportline()
 {
  for (cSheet sheet:Excel.sheet)
   {
   if (sheet.isFocused()){ sheet.exportLine (sheet.tSelectedLine);}
   } 
}

void showstack(String s) {
  stackArea.append( " " + s + "\n");
}

void printstack(String s) {
 stackArea.clear();
 stackArea.append(  s + "\n");
}
void printstack2(String s) {
 //stackArea2.clear();
 stackArea2.append(  s + "\n");
}


void profileList(int n) {
  String profileName = files[n];
  if (debug) println ("select profile :"+profileName);
  for (cSheet sheet:Excel.sheet)
   {
    sheet.load( "data\\Profiles\\"+profileName+".csv");
   } 
}

// création de la liste des fichiers csv du répertoire data/Profiles
void createFilesListBox(){
  File dir = new File(sketchPath("data\\Profiles"));
  File[] fileList = dir.listFiles();   // Liste tous les fichiers dans le répertoire
  ArrayList<String> csvFiles = new ArrayList<String>();
  for (File file : fileList) 
   {   // Parcourt la liste de fichiers
    if (file.isFile() && file.getName().toLowerCase().endsWith(".csv")) 
     {     
      csvFiles.add(removeExtension(file.getName()));
     }
   }
  files = new String[csvFiles.size()]; // Initialise le tableau de chaînes avec la taille du nombre de fichiers .csv trouvés
  for (int i = 0; i < csvFiles.size(); i++) { // Copie les noms de fichiers sans extension dans le tableau
    files[i] = csvFiles.get(i);
  }
}


void request(){
 Excel.sheet[0].setCell("700.5",1,1);
 Excel.sheet[0].setCell(    "7",2,1);
 Excel.sheet[0].setEquation("=A1*B1",3,1);
 
 
 String eq = Excel.sheet[0].getEquation(3,1);
 println(eq);
  String res= Excel.sheet[0].Evaluate(eq) ;
  println(res);
 Excel.sheet[0].setCell(res,3,1);
  
 

 
 //Excel.sheet[1].setCell("fff",3,5);
 //Excel.sheet[1].setCell(3.14,2,5);
 //Excel.sheet[1].setCell(15,6,5);
 //String s =Excel.sheet[1].getCell(6,5);
 //Excel.sheet[0].setCell(s,6,5);
 //int[] i=Excel.sheet[1].getSheetInfo();
 //println(i[0]+" "+ i[1]);
 //Excel.sheet[0].setCell(i[0],1,1);
 //Excel.sheet[0].setCell(i[1],1,2);
  
}
boolean it=false;
void request22(){
  if (it==true) {it=false;return;}
 int[] i=Excel.sheet[1].getSheetInfo();
 for (int y=0;y<i[1];y++)
 {
  for (int x=0;x<i[0];x++)
  {
   Excel.sheet[1].setCell((x+1)+(y*i[0]+1),x+1,y+1);
 }
 }
 it=true;
}

void request2()
{

  Excel.sheet[0].setCell("Exemple",1,1);
  Excel.sheet[0].setCell("de",2,1);
  Excel.sheet[0].setCell("formules",3,1);

  for(int i=2;i<9;i++){    

  Excel.sheet[0].setCell(str(10*i),1,i);
  Excel.sheet[0].setCell(str(5.23*i),2,i);  
  Excel.sheet[0].setCell("Somme=",3,i);
  Excel.sheet[0].setEquation("=A"+i+"+B"+i,4,i);}
  
}

void iteration2(){
 for(int z=0;z<100;z++)
  {
   int[] i=Excel.sheet[1].getSheetInfo();
   for (int y=0;y<i[1];y++)
    {
     for (int x=0;x<i[0];x++)
     {
     String s = Excel.sheet[1].getCell(x+1,y+1);
     if ( (s!=null) && (s!="") && (s!=" ") )  
      {
       try 
        {
         float j =Float.parseFloat(s);
         Excel.sheet[1].setCell(j+1,x+1,y+1);
        }
       catch (Exception e) {} 
      }
     }   
    }
  }
}

void color0 (){   loadColorScheme(0); Excel.updateColors(); for (cSheet sheet:Excel.sheet)     {       sheet.updateColors();     } }
void color1 (){   loadColorScheme(1); Excel.updateColors(); for (cSheet sheet:Excel.sheet)     {       sheet.updateColors();     } }
void color2 (){   loadColorScheme(2); Excel.updateColors(); for (cSheet sheet:Excel.sheet)     {       sheet.updateColors();     } }


// void color3(){
// if (drawTable==true) {drawTable=false;}
// else {drawTable=true;}
// }
 
// void color33(){
//   noStroke();
//  colorMode(HSB, 255);
//for (int i = 0; i < 25; i++) {
//  for (int j = 0; j < 25; j++) {
//    fill(i*10, j*10, 100);
//    stroke(i*10, j*10, i*j);
//    rect(i*10,j*10,10,10);
//    //point(i, j);
//  }
//  colorMode(RGB,255);
//}
