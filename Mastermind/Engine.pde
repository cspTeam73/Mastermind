 /*
  
  guesses will be handled by a 2D array
  
  six colors will be represented by the numbers 0-5
  
  13 layers (0-12)
  
*/

//
//Variables
//

int[][] Guesses;
int currentLayer;

int[] Code;

//Pegs
int WPegs;
int RPegs;

//win/lose
boolean Win;
boolean Lose;

//
//Game logic
//


/*
  Function: StartNewGame
  Initializes all game variables and then handles game logic.
*/
void StartNewGame()
{
  InitGameVariables();
  
}

/*
  Function: InitGameVariables
  Initializes all game variables.
*/
void InitGameVariables()
{
  Guesses = new int[13][4];
  currentLayer = 0;
  
  Code = CreateCode();
  
  Win = false;
  Lose = false;
}

/*
  function: CreateCode
  Returns an array of 4 random integers between 0 and 5
*/
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
  checks the guess in the current layer of Guesses
  increments the currentLayer
  Checks if the player has won/lost and toggles the respective variable to true if applicable
  outputs how many red/white pegs need to be displayed in an array in the form:
  0: White
  1: Red
  
*/
int[] CheckGuess()
{
  int[] r = new int[2];
  
  r[0] = checkWhite(); // White
  r[1] = checkRed();   // Red
  
  // check if we win
  if(r[1] == 4)
  {
    Win = true;
    // enter end game screen here?
  }
  
  currentLayer++; // increment the layer
  
  //check if we lose
  if(currentLayer>13)
  {
    Lose = true;
    // enter end game screen here?
  }
  
  return r;
}

/*
  function: CheckWhite
  checks for and returns the number of white pegs that needs to be displayed
*/
int CheckWhite()
{
  int r = 0;
  int[] codeColors  = new int[6];
  int[] guessColors = new int[6];
  
  //seperate out all the colors in the code and the guess
  for(int i = 0; i<4; i++)
  {
    codeColors[Code[i]]++;
    guessColors[Guess[currentLayer][i]]++;
  }
  
  //check guessColors against codeColors
  for(int i = 0; i<6; i++)
  {
    while(codeColors[i]>0 && guessColors[i]>0)
    {
      r++;
      codeColors[i]--;
      guessColors[i]--;
    }
  }
  return r;
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



