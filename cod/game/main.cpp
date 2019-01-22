#include <os.h>
#include <SDL/SDL_config.h>
#include <SDL/SDL.h>

int main(void) {
	SDL_Surface *screen;
	nSDL_Font *font;
	SDL_Init(SDL_INIT_VIDEO);
	screen = SDL_SetVideoMode(320, 240, has_colors ? 16 : 8, SDL_SWSURFACE);
	font = nSDL_LoadFont(NSDL_FONT_TINYTYPE,
	                     29, 43, 61);
	SDL_FillRect(screen, NULL, SDL_MapRGB(screen->format, 0, 255, 0));
	SDL_Delay(3000);
	SDL_Quit();
	return 0;
}
