#ifndef Game_hpp
#define Game__hpp

#include <ostream>
#include <iostream>
#include <os.h>
#include <SDL/SDL_config.h>
#include <SDL/SDL.h>

class Game {

public:
  Game();
  ~Game();

  void init(int width, int height);
  
  void handleEvents();
  void update();
  void render();
  void clean();

  bool running(){return isRunning;};

private:
  bool isRunning;
  SDL_Surface *window;
};

#endif /*gamehpp*/

