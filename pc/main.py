import pygame
import re
import math

from settings import settings
import widgets

pygame.display.init()
pygame.font.init()

window = pygame.display.set_mode((1280, 720))


outside_border = pygame.Rect(settings.padding_x, settings.padding_y, 1280 - (2*settings.padding_x), 720 - (2*settings.padding_y))
widgets = [
    widgets.ConsoleWidget(settings, pygame.Rect(outside_border.x, outsdie_border.y, 100, 100))
]

running: bool = True
while running:
    window.fill(settings.background_color)
    
    pygame.draw.rect(window, settings.border_color, outside_border, settings.border_width) 
    
    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
            running = False

        if event.type == pygame.QUIT:
            running = False

