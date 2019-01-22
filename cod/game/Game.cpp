#include "Game.hpp"

Game::Game()
{}
Game::~Game()
{}

void Game::init(int width, int height)
{
  if(SDL_Init(SDL_INIT_EVERYTHING) == 0){
    std::cout << "YEY" << std::endl;

    window = SDL_SetVideoMode(width, height, has_colors ? 16 : 8, SDL_SWSURFACE);
    if(window)
    {
      std::cout << "window YEY" << std::endl;
    }

  }
}

void Game::handleEvents()
{
  SDL_Event event;
  SDL_PollEvent(&event);
  switch (event.type) {
  case SDL_QUIT:
    isRunning = false;
    break;
  default:
    break;
  }
}

void Game::update()
{}

void Game::render()
{
  SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0,0,0));

  SDL_RenderPresent();
}

void Game::clean()
{}

