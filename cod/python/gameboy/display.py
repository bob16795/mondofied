import pygame
class Display():
  def __init__(self):
    """
    Bit 7 - LCD Display Enable             (0=Off, 1=On)
    Bit 6 - Window Tile Map Display Select (0=9800-9BFF, 1=9C00-9FFF)
    Bit 5 - Window Display Enable          (0=Off, 1=On)
    Bit 4 - BG & Window Tile Data Select   (0=8800-97FF, 1=8000-8FFF)
    Bit 3 - BG Tile Map Display Select     (0=9800-9BFF, 1=9C00-9FFF)
    Bit 2 - OBJ (Sprite) Size              (0=8x8, 1=8x16)
    Bit 1 - OBJ (Sprite) Display Enable    (0=Off, 1=On)
    Bit 0 - BG/Window Display/Priority     (0=Off, 1=On)
    """
    LCDC = [0,0,0,0,0,0,0,0]
    pygame.init()
    pygame.display.init()
    pygame.display.set_mode((160, 144))
  def update(self):
    pass
lol = Display()
