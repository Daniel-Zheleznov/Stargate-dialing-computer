import pygame

class Widget:
    def __init__(self, settings, provided_rect, draw_border: bool = True):
        self.settings = settings
        self.provided_rect = provided_rect
        self.draw_border = draw_border

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

    def draw(self, surface: pygame.Surface):
        pass


class FluxControllerWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime):
        pass

    def draw(self, surface: pygame.Surface):
        pass


class StatusBarWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime):
        pass

    def draw(self, surface: pygame.Surface):
        pass


class StargateWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect, False)

        self.img = pygame.image.load("C:\\Users\\thinkstation\\Desktop\\stargate-inner-ring.png")
        
    def update(self, deltatime):
        pass

    def draw(self, surface: pygame.Surface):
        surface.blit(self.img, self.provided_rect.topleft)
