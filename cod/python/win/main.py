import os
import pygame 
import subprocess
import time

first_item = 0

os.environ['SDL_VIDEO_CENTERED'] = '1'
pygame.init()

pygame.display.init()
screen = pygame.display.set_mode( (320, 240), pygame.NOFRAME)

commands = subprocess.check_output(['/usr/bin/sh', '-c', 'compgen -c | sort'])
cmds = commands.split(b'\n')

pygame.font.init()
font = pygame.font.match_font('NotoSans')
myfont = pygame.font.SysFont(font, 15)
while True:
    screen.fill((216,216,216))
    for i in range(first_item,first_item+20):        
        textsurface = myfont.render(cmds[i],True, (201,194,64))
        screen.blit(textsurface,(0,15*(i-first_item)))
    time.sleep(.1)
    first_item += 1
    pygame.display.update()

time.sleep(1)
