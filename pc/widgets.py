import pygame

class Widget:
    def __init__(self, settings, provided_rect):
        self.settings = settings
        self.rect = provided_rect

    def update(self, deltatime):
        pass

    def draw(self, surface):
        raise NotImplementedError
      
        
class ConsoleWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime):
        pass