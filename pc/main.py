import pygame
import re

pygame.font.init()

window = pygame.display.set_mode((1280, 720))

settings = {
    "background":   "#05080D",
    "border":       "#0E2A35",

    "console-font": pygame.font.SysFont("Consolas", 25),
    "console-i":    "#FF2E60", # command icon
    "console-c":    "#FFFF60", # command text
    "console-t":    "#4FD3E8", # title
    "console-l":    "#6FA8B8", # label
    "console-v":    "#D8F3FF", # value
}


console_info = { "lines": [ "$<i$>$<c$info", "$^t$PC Name", "$^l$-------", "$<l$Model:$>v$4800X" ], }
console_tag  = re.compile(r"\$([<^>])([cvlti])\$")

running = True
while running:
    window.fill(settings["background"])

    # outside border
    outside = pygame.draw.rect(window, settings["border"], (10, 30, 1280-20, 720-60), 5)

    # console
    console = pygame.draw.rect(window, settings["border"], (outside.x + 10, outside.y + 10, (outside.w - 20) // 4, (outside.h - 20) * (2/3)), 5)

    x, y = 40, 40
    for raw_line in console_info["lines"]:
        # Create ["", "<", "i", ">", ...]
        parts = console_tag.split(raw_line)

        # Group to [["<", "i", ">"], ["<", "c", "info"]]
        line = []
        for i in range(1, len(parts), 3):
            line.append([parts[i], parts[i+1], parts[i+2]])

        x = 40
        max_height = 0
        for align, color, text in line:
            text_surf = settings["console-font"].render(text, True, settings["console-"+color])

            max_height = max(text_surf.get_height(), max_height)

            match align:
                case "^":
                    x = (console.w - text_surf.get_width()) // 2
                case ">":
                    x = (console.w - 10 - 40 - text_surf.get_width())

            if color == "i": # icon is treated as seperate
                x = 40 - text_surf.get_width()

            window.blit(text_surf, (console.x+x, console.y+y))
            x += text_surf.get_width() + 10

        y += max_height

    pygame.display.update()

    for event in pygame.event.get():
        if event.type == pygame.KEYDOWN or event.type == pygame.MOUSEBUTTONDOWN:
            running = False

        if event.type == pygame.QUIT:
            running = False

