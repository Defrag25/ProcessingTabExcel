////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Classe Pile d'appel /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Pile maPile;

// Définir une classe pour la pile
class Pile {
  ArrayList<int[]> elements;
  
  // Constructeur
  Pile() {
    elements = new ArrayList<int[]>();
  }
  
  // Fonction pour empiler un triplet de données
  void push(int nombre1, int nombre2, int nombre3) {
    int[] couple = {nombre1, nombre2, nombre3};
    elements.add(couple);
  }
  
  // Fonction pour dépiler un couple de données
  int[] pop() {
    if (!elements.isEmpty()) {
      int[] couple = elements.remove(elements.size() - 1);
      return couple;
    } else {
      return null; // Si la pile est vide, retourne null (ou un autre indicateur de votre choix)
    }
  }
 void print()
  {
   for (int i = 0; i < elements.size(); i++) 
    {
     int[] valeur = elements.get(i);
     showstack(nf(i,0,0)+"> "+valeur[0]+";"+valeur[1]+";"+valeur[2]);
    }
  }
  
  void clear() {
    elements.clear();
  }
  
}

// Créer une instance de la pile


void printstack(){
 stackArea.clear();
 maPile.print(); 
}
