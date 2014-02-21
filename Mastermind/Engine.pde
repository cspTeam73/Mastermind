/*
  
  guesses will be handled by a 2D array
  
  six colors will be represented by the numbers 0-5
  
  13 layers (0-12)
  
*/

int[][] Guesses;
int currentLayer;

int[] Code;

void StartNewGame()
{
  InitGameVariables();
  
}

void InitGameVariables()
{
  Guesses = new int[13][4];
  currentLayer = 0;
  
  Code = CreateCode();
}

int[] CreateCode()
{
  int[] r = new int[4];
  
  for(int i = 0; i<4; i++)
  {
    r[i] = int(random(0, 5));
  }
  
  return r;
}

/*
  function: CheckGuess
  checks the guess in the current layer of Guesses and then increments the currentLayer
  outputs how many red/white pegs need to be displayed in an array in the form:
  0: White
  1: Red
  
*/
int[] CheckGuess()
{
  
  
  //White
  
}

/*
  function: CheckWhite
  checks for and returns the number of white pegs that needs to be displayed
*/
int CheckWhite()
{
  int r = 0;
  int[] colors = new int[6];
  for(int i = 0; i<4; i++)
  {
    colors[Code[i]]++;
  }
  
}

/*
  function: CheckRed
  checks for and returns the number of red pegs that need to be displayed
*/
int CheckRed()
{
  int r = 0;
  for(int i = 0; i<4; i++)
  {
    if(Code[i] == Guesses[currentLayer][i])
      r++;
  }
  return r;
}


