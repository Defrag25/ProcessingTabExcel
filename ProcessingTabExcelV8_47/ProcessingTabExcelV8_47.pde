// ProcessingTabExcel V8.45
// Reste les pb suivants:
// > Pb lors du chargement de fichiers csv non uniformes et meme des fois sans raisons 
// > Pb de gestion des séquences
// > Pb lors de l'insertion / suppression d'une colonne
//   > l'insertion efface les données précédement entrées
// > Pb des sheet qui sont référencées à Excel !!!!!!
// > Pb de l'indexage des feuilles 
//    apres suppression d'une feuille , celle ci passe à l'index inférieure (ou pas suivant si elle est avant l'index suupprimé)
//    ce qui a pour effet le non fonctinnement de sheet[n] qui passe à une autre feuille 
// > Permettre l'édition des équations (string qui commence par =)
//    dans ce cas la string est placée dans sheet.equation

//    > la solution est d'inhibber le + et - si la string commence par un =
// > Il faut ajouter le redimensionnement des colonnes/lignes quand on doble-clic sur colonne/ligne
// > Pb
// >les calculs sont faux
//    > 1/0.00001 donne -1...
// >le bouton DEL ne fonctionne pas
// >le deplacement des celulles ne fonctionne pas bien surtout en colonnes
// >la cselection des celulles ne fonctionne pas quand tstartX/Y !=0 


//Tableau de Tab
final boolean debug=false;
final String versionNumber = "v8.45";
final String versionAuthor = "ERM version";

String cheminDeLApplication; 
int id;
boolean needToUnslectAll=false;
boolean showCursorCoord = true;
import java.io.*;
cExcel Excel;
void setup() {
  
  size (1250, 500);
  background(111);
  cheminDeLApplication = sketchPath("");
  if (debug) println("Chemin de l'application : " + cheminDeLApplication);
  surface.setResizable(true);
  surface.setLocation(50, 100);

  Excel = new cExcel( "Excel "+versionNumber)
//          .show(true)
          .isResizable(true)
          .setPosition(0,65)
          .setSize(600,400);
  textSize(12);
  //MAX518Setup();
  loadSettings();
  MCP7425Setup();  
  GUI_Setup();
  setupGraph();
} 


void draw () 
 {// println(cp5.getTab());
  background(111);
  Excel.draw();
  printStatusBar();
  printstack();
//  drawGraph();
///iteration();
//if(it) iteration2();
 } 
 
void iteration(){
 String s = Excel.sheet[1].getCell(1,1);
 if ( (s!=null) && (s!="") && (s!=" ") )
 {
   try {
   float i =Float.parseFloat(s);
   Excel.sheet[1].setCell(i+1,1,1);//
   }
  catch (Exception e) {}
 }  
}

void printStatusBar(){
 if(showCursorCoord==true) 
  {
     fill(255);
   if (drawMemory)
    {
     Runtime runtime = Runtime.getRuntime();
     long totalMemory = runtime.totalMemory();   // Get the total memory in bytes
     //long maxMemory = runtime.maxMemory(); // Get the maximum available memory in bytes
     long freeMemory = runtime.freeMemory(); // Get the free memory in bytes
     // Convert bytes to megabytes for easier understanding
     float totalMemoryMB = totalMemory / (1024.0 * 1024.0);
//     float maxMemoryMB = maxMemory / (1024.0 * 1024.0);
     float freeMemoryMB = freeMemory / (1024.0 * 1024.0);
     text("Mémoire libre : " +nf(freeMemoryMB, 0, 1) + "/"+nf(totalMemoryMB, 0, 0)+" Mo", width-300,height-5);
    }
     text("("+mouseX+":"+mouseY+")",width-75,height-5);
     text(Excel.newVal,0,height-5);
   } 
}

void printStatusBarString(String s)
 {
  fill(44);
  stroke(0); 
  rect(0, height-20, width, 20);
  fill(255);
  if(showCursorCoord==true) 
   {
    text("("+mouseX+":"+mouseY+")",width-75,height-5);
   }
  text(s, 12, height-5);
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Gestion de l'affichage des objets
void controlEvent(ControlEvent theControlEvent) {
  if (theControlEvent.isTab()) {    
//    println("got an event from tab : "+theControlEvent.getTab().getName()+" with id "+theControlEvent.getTab().getId());
    id=theControlEvent.getTab().getId();
    if (id==1){Excel.show();}
    if (id==2){Excel.hide();}
  }
}
// Fin de la gestion de l'affichage des objets
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// ----------------------------------------------------------------------
void mouseWheel(MouseEvent event) { Excel.mouseWheel(event);}
void mouseDragged()               { Excel.mouseDragged();   } 
void mouseReleased()              { Excel.mouseReleased();  }
void mousePressed()               { Excel.mousePressed();   }
void mouseClicked()               { Excel.mouseClicked();   }
void keyPressed()                 { Excel.keyPressed();     } 
