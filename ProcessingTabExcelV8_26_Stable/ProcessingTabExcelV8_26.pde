// ProcessingTabExcel V8.2

//Tableau de Tab


String cheminDeLApplication; 

boolean needToUnslectAll=false;
boolean showCursorCoord = true;

void setup() {
  size (900, 500);
  background(111);
  cheminDeLApplication = sketchPath("");
  println("Chemin de l'application : " + cheminDeLApplication);
  surface.setResizable(true);
  surface.setLocation(50, 100);
  Excel = new cExcel( "Excel", 10 , 80, 700 , 400);
  textSize(12);
  MAX518Setup();
  
 
  GUI_Setup();
} 



void draw () 
 {
  background(111);
  Excel.draw();
  int foc=-1;
  int n=0;
  printStatusBar();
 } 

void printStatusBar(){
 
  if(showCursorCoord==true) 
   {
        Runtime runtime = Runtime.getRuntime();
  
  // Get the total memory in bytes
  long totalMemory = runtime.totalMemory();
  
  // Get the maximum available memory in bytes
  long maxMemory = runtime.maxMemory();
  
  // Get the free memory in bytes
  long freeMemory = runtime.freeMemory();
  
  // Convert bytes to megabytes for easier understanding
  float totalMemoryMB = totalMemory / (1024.0 * 1024.0);
  float maxMemoryMB = maxMemory / (1024.0 * 1024.0);
  float freeMemoryMB = freeMemory / (1024.0 * 1024.0);
  

 
  fill(255);
    text("Mémoire libre : " +nf(freeMemoryMB, 0, 1) + "/"+nf(totalMemoryMB, 0, 0)+" Mo", width-300,height-5);

    text("("+mouseX+":"+mouseY+")",width-75,height-5);
   }
 
}

void printStatusBarString(String s){
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

// ----------------------------------------------------------------------
void mouseWheel(MouseEvent event) { Excel.mouseWheel(event); }
void mouseDragged()               { Excel.mouseDragged(); } 
void mouseReleased()              { Excel.mouseReleased();}
void mousePressed()               { Excel.mousePressed();}
void mouseClicked()               { Excel.mouseClicked();}
void keyPressed()                 { Excel.keyPressed();} 
