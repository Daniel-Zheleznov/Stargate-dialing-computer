import pygame
from PIL import Image
import math

pygame.init()

window = pygame.display.set_mode((1280, 720))
clock = pygame.time.Clock()

# inner = Image.open("assets\\stargate-inner-ring.png")
inner = pygame.image.load("assets\\stargate-inner-ring.png")
angle = 0

RING_DX = 178.5 - 182   # ring centre minus image centre, in pixels
RING_DY = 179.0 - 182

elapsed = 0.0
running = True
while running:

    window.fill("purple")

    # temp = pygame.transform.rotozoom(inner, angle, 1)
    rad = math.radians(angle)

    # ring centre offset from the image centre, rotated the same way as the image (counter-clockwise on screen)
    rdx = RING_DX * math.cos(rad) + RING_DY * math.sin(rad)
    rdy = -RING_DX * math.sin(rad) + RING_DY * math.cos(rad)

    temp = pygame.transform.rotate(inner, angle)
    temp_rect = temp.get_rect(center = (round(640 - rdx), round(360 - rdy)))
    window.blit(temp, temp_rect)

    angle += 5

    elapsed += clock.tick() / 1000.0

    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

        if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
            running = False
