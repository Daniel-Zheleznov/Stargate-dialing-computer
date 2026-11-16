import pygame
from PIL import Image

pygame.init()

window = pygame.display.set_mode((1280, 720))
clock = pygame.time.Clock()

# inner = Image.open("assets\\stargate-inner-ring.png")
inner = pygame.image.load("assets\\stargate-inner-ring.png")
angle = 0

SWEEP_DEG = 90.0
SWEEP_FRAMES = 33   # ticks for the sweep
HOLD_FRAMES = 30    # ticks to hold at 90 degrees
PERIOD = SWEEP_FRAMES + HOLD_FRAMES
TICK_RATE = 12      # ticks per second, same as the Flash file

def ring_angle_deg(tick):
    """Clockwise angle in degrees for a tick count."""
    tick %= PERIOD
    if tick < SWEEP_FRAMES:
        return SWEEP_DEG * tick / SWEEP_FRAMES
    return SWEEP_DEG

elapsed = 0.0
running = True
while running:

    window.fill("purple")

    temp = pygame.transform.rotozoom(inner, ring_angle_deg(elapsed * 12), 1)
    window.blit(temp, temp.get_rect(center=(640, 360)))

    angle += 5

    elapsed += clock.tick() / 1000.0

    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

        if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
            running = False
