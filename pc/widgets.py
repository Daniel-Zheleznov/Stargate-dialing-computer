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

        self.elapsed_time = 0

        self.images = [
            pygame.image.load("assets\\stargate.png"),
            pygame.image.load("assets\\stargate-inner-ring.png"),

            pygame.image.load("assets\\stargate-dialing-locking-1.png"),
            pygame.image.load("assets\\stargate-dialing-locked-1.png"),

            pygame.image.load("assets\\stargate-dialing-locking-2.png"),
            pygame.image.load("assets\\stargate-dialing-locked-2.png"),

            pygame.image.load("assets\\stargate-dialing-locking-3.png"),
            pygame.image.load("assets\\stargate-dialing-locked-3.png"),

            pygame.image.load("assets\\stargate-dialing-locking-4.png"),
            pygame.image.load("assets\\stargate-dialing-locked-4.png"),

            pygame.image.load("assets\\stargate-dialing-locking-5.png"),
            pygame.image.load("assets\\stargate-dialing-locked-5.png"),

            pygame.image.load("assets\\stargate-dialing-locking-6.png"),
            pygame.image.load("assets\\stargate-dialing-locked-6.png"),

            pygame.image.load("assets\\stargate-dialing-locking-7.png"),
            pygame.image.load("assets\\stargate-dialing-locked-7.png"),
        ]

        self.angle = 0
        self.wanted_angle = 0
        self.image_index = 0

        self.started = False

    def rotate_to(self, degree: int):
        self.wanted_angle = degree
        diff = self.wanted_angle - self.angle

        if abs(diff) <= 0.1:
            self.angle = self.wanted_angle
            return True

        progress = diff / self.wanted_angle
        step = (1 + (1.70158) * pow(progress - 1, 3) + (1.70158) * pow(progress - 1, 2))
        self.angle += step if diff > 0 else -step
        return False

    def update(self, deltatime_in_ms):
        self.elapsed_time += deltatime_in_ms
        
        if self.started == True:            
            if self.rotate_to(300 * (360 / 39)):
                self.started = False
                return

        if ((self.elapsed_time % 1500) == 0) and self.started == False:
            self.started = True

    def draw(self, surface: pygame.Surface):
        inner_temp = pygame.transform.rotozoom(self.images[1], self.angle, 1)
        surface.blit(inner_temp, [
            self.provided_rect.x + ((self.provided_rect.width - inner_temp.get_width()) // 2),
            self.provided_rect.y + ((self.provided_rect.height - inner_temp.get_height()) // 2)
        ])

        outer_temp = self.images[self.image_index]
        surface.blit(outer_temp, self.provided_rect.topleft)
