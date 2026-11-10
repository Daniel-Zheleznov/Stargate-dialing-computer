import pygame

class Widget:
    def __init__(self, settings, provided_rect, draw_border: bool = True):
        self.settings = settings
        self.provided_rect = provided_rect
        self.draw_border = draw_border

    def update(self, deltatime_in_ms):
        pass

    def draw(self, surface):
        raise NotImplementedError
      
        
class ConsoleWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime_in_ms):
        pass

    def draw(self, surface: pygame.Surface):
        pass


class FluxControllerWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime_in_ms):
        pass

    def draw(self, surface: pygame.Surface):
        pass


class StatusBarWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect)
        
        self.settings.console_font = pygame.font.SysFont("bauhaus93", 18)
        
    def update(self, deltatime_in_ms):
        pass

    def draw(self, surface: pygame.Surface):
        pass


class StargateWidget(Widget):
    def __init__(self, settings, provided_rect):
        super().__init__(settings, provided_rect, False)

        self.images = [
            pygame.image.load("assets\\stargate.png"),
            pygame.image.load("assets\\stargate-inner-ring.png"),

            pygame.image.load("assets\\stargate-dialing-progress-1.png"),
            pygame.image.load("assets\\stargate-dialing-progress-2.png"),
            pygame.image.load("assets\\stargate-dialing-progress-3.png"),
        ]

        self.angle = 0
        self.image_index = 0

    def update(self, deltatime_in_ms):
        pass

    def draw(self, surface: pygame.Surface):
        inner_temp = pygame.transform.rotozoom(self.images[1], self.angle, 1)
        surface.blit(inner_temp, [
            self.provided_rect.x + ((self.provided_rect.width - inner_temp.get_width()) // 2),
            self.provided_rect.y + ((self.provided_rect.height - inner_temp.get_height()) // 2)
        ])

        outer_temp = self.images[self.image_index]
        surface.blit(outer_temp, self.provided_rect.topleft)
