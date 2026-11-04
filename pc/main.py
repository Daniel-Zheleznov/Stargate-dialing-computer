import pygame
import re

pygame.font.init()

window = pygame.display.set_mode((1280, 720))

settings = {
    "background":   "#05080D",
    "border":       "#0E2A35",

    "console-font": pygame.font.SysFont("arial", 35),
    "console-c":    "#FF2E60", # command
    "console-t":    "#4FD3E8", # title
    "console-l":    "#6FA8B8", # label
    "console-v":    "#D8F3FF", # value
}


console_info = { "lines": [ "$<c$info", "$<t$PC Name", "$<l$-------", "$<l$Model:$>v$4800X" ], }
console_tag  = re.compile(r"\$([<^>])([cvlt])\$")


running = True
while running:
    window.fill(settings["background"])

    # outside border
    outside = pygame.draw.rect(window, settings["border"], (10, 30, 1280-20, 720-60), 5)

    # console
    console = pygame.draw.rect(window, settings["border"], (outside.x + 10, outside.y + 10, (outside.w - 20) // 4, (outside.h - 20) * (2/3)), 5)

    x, y = 40, 40
    for line in console_info["lines"]:
        parts = console_tag.split(line)

        segments = []
        for i in range(1, len(parts), 3):
            align, type_, text = parts[i], parts[i + 1], parts[i + 2]
            segments.append((align, type_, text))

        for align, type_, text in segments:
            # surf = settings["console-font"].render(text, True, settings["console-" + type_])
            print(f"align={align} type={type_} text={text!r}")

    quit()

    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
            running = False

        if event.type == pygame.QUIT:
            running = False

