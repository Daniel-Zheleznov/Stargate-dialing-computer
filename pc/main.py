import pygame
from pygame._sdl2.video import Window
import re
import math
import os

from settings import settings
import widgets

os.environ["SDL_VIDEO_MINIMIZE_ON_FOCUS_LOSS"] = "0"

pygame.display.init()
pygame.font.init()


desktop_size = [
    pygame.display.Info().current_w,
    pygame.display.Info().current_h,
]
window = pygame.display.set_mode((1280, 720))
sdl_window = Window.from_display_module()
clock = pygame.time.Clock()

def toggle_fullscreen():
    global window
    if window.get_flags() & pygame.NOFRAME:
        x = (desktop_size[0] - 1280) // 2
        y = max((desktop_size[1] - 720) // 2, 50)
        sdl_window.position = (x,y)
        window = pygame.display.set_mode([1280, 720])
    
    else:
        sdl_window.position = (0,0)
        window = pygame.display.set_mode(desktop_size, pygame.NOFRAME)


outside_border         = pygame.Rect(
    settings.padding_x, 
    settings.padding_y, 
    1280 - (2*settings.padding_x), 
    720 - (2*settings.padding_y)
)
console_border         = pygame.Rect(
    outside_border.x + settings.border_width + settings.padding_x, 
    outside_border.y + settings.border_width + settings.padding_x, 
    (outside_border.w - (2*settings.border_width) - (2*settings.padding_x)) // 5, 
    (outside_border.h - (2*settings.border_width) - (3*settings.padding_x)) * 2 // 3
)
flux_controller_border = pygame.Rect(
    outside_border.x + settings.border_width + settings.padding_x, 
    console_border.bottom + settings.padding_x, 
    (outside_border.w - (2*settings.border_width) - (2*settings.padding_x)) // 5, 
    (outside_border.h - (2*settings.border_width) - (3*settings.padding_x)) - console_border.h
)
status_bar_border      = pygame.Rect(
    flux_controller_border.right + settings.padding_x,
    flux_controller_border.bottom - (flux_controller_border.h // 2),
    (outside_border.right - settings.border_width - settings.padding_x) * (3/5),
    flux_controller_border.h // 2
)
stargate_border        = pygame.Rect(
    console_border.right + settings.border_width + settings.padding_x,
    console_border.y,
    status_bar_border.w,# (outside_border.right - settings.border_width - settings.padding_x) - (console_border.right + settings.border_width + settings.padding_x),
    status_bar_border.y - settings.padding_x - console_border.y
)
widgets = [
    widgets.ConsoleWidget(settings, console_border),
    widgets.FluxControllerWidget(settings, flux_controller_border),
    widgets.StatusBarWidget(settings, status_bar_border),
    widgets.StargateWidget(settings,stargate_border)
]

canvas = pygame.Surface((1280, 720))

running: bool = True
deltatime = 0
start = 0
while running:
    start = pygame.time.get_ticks()

    canvas.fill(settings.background_color)
    
    pygame.draw.rect(canvas, settings.border_color, outside_border, settings.border_width)

    for widget in widgets:
        if widget.draw_border:
            pygame.draw.rect(canvas, settings.border_color, widget.provided_rect, settings.border_width)

        widget.update(deltatime)
        widget.draw(canvas)

    screen = pygame.display.get_surface()
    screen.blit(pygame.transform.scale(canvas, screen.get_size()), (0, 0))

    clock.tick()
    pygame.display.update()

    for event in pygame.event.get():
        # if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
        #     running = False

        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_F11:
                toggle_fullscreen()
            
            else:
                running = False

        if event.type == pygame.QUIT:
            running = False

    deltatime = pygame.time.get_ticks() - start

