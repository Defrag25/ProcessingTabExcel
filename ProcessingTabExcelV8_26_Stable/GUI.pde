import controlP5.*;

ScrollableList profileList;
Textarea stackArea;
String[] files;
ControlP5 cp5;

void GUI_Setup(){
  createFiles();  
  cp5 = new ControlP5(this);
 // PFont pfont = createFont("Arial", 25, true); // use true/false for smooth/no-smooth
 //// ControlFont Pfont = new ControlFont(pfont, 16);
 // ControlFont sfont = new ControlFont(createFont("consolas", 12));

   stackArea = cp5.addTextarea("Stack")
                  .setPosition(600, 63)
                  .setSize(100, 300)
                  //.setFont(sfont)
                  .setLineHeight(14)
                  .setColor(#FFFFFF)
                  .setColorBackground(#444444)
                  .setScrollBackground(#222222)
                  .scroll(1)
                  .showScrollbar().hide();;

  
  profileList = cp5.addScrollableList("profileList")
                  .setPosition(0, 0)
                  .setSize(200, 300)
                  .setBarHeight(25)
                  .setItemHeight(25)
                  .setItems(files)
                  .close();
  cp5.addButton("save")  .setLabel("save")  .setPosition(210,0) .setSize(50,25) ; 
  cp5.addButton("exportline") .setLabel("export line") .setPosition(270,1).setSize(50,25) ;
  cp5.addButton("bpStart") .setLabel("START") .setPosition(330,0).setSize(50,25) ;
  cp5.addButton("bpStop") .setLabel("STOP")   .setPosition(330,30).setSize(50,25) ;
  cp5.addButton("Add") .setLabel("Add")       .setPosition(390,0).setSize(50,25) ;
  cp5.addButton("Remove") .setLabel("Remove") .setPosition(390,30).setSize(50,25) ;
  //profileList.setValue(0);
  

  maPile = new Pile();
}

String removeExtension(String fileName) {
  int extensionIndex = fileName.lastIndexOf('.');
  if (extensionIndex != -1) {
    return fileName.substring(0, extensionIndex);
  }
  return fileName;
}

void save ()   { for (cSheet sheet:Excel.sheet){       sheet.save(""); }}

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

//void showstack(int code1, String s) {
void showstack(String s) {
//void ProgPrint(int code1, String s) {
  //codes               0          1          2          3          4          5          6          7          8          9          10         11
  String[] codes = {"       ", "[ECHO] ", "[SETUP]", "[TRACE]", "[PRG] ", "[AXES] ", "[ERROR]", "[WARN] ", "[INFO] ", "     > ", "[CMD]  ", "[APP]  "};
//  stackArea.append(codes[code1] + " " + " " + s + "\n");
  stackArea.append( " " + s + "\n");
}


void profileList(int n) {
  String profileName = files[n];
  println ("select profile :"+profileName);
  for (cSheet sheet:Excel.sheet)
   {
    sheet.load( "data/Profiles/"+profileName+".csv");
   } 
}

// création de la liste des fichiers csv du répertoire data/Profiles
void createFiles(){
  File dir = new File(sketchPath("data/Profiles"));
   // Liste tous les fichiers dans le répertoire
  File[] fileList = dir.listFiles();
  ArrayList<String> csvFiles = new ArrayList<String>();
  
  // Parcourt la liste de fichiers
  for (File file : fileList) {
    if (file.isFile() && file.getName().toLowerCase().endsWith(".csv")) {
      csvFiles.add(removeExtension(file.getName()));
    }
  }
  
  // Initialise le tableau de chaînes avec la taille du nombre de fichiers .csv trouvés
  files = new String[csvFiles.size()];
  
  // Copie les noms de fichiers sans extension dans le tableau
  for (int i = 0; i < csvFiles.size(); i++) {
    files[i] = csvFiles.get(i);
  }
  
  // Affiche les noms de fichiers dans la console
      print("( ");
  for (String fileName : files) {
    print(fileName+"; ");
  }
  println( " ) ");
}

void Add()
 {
   //int n= Excel.sheet.length;
      cSheet n = new cSheet ( "Addition" ,10 , 50 , 500 ,600  );
    Excel.add(n); 
}

void Remove()
{Excel.removeSelected();
}
