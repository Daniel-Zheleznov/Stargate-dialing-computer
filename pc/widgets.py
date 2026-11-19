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

        self.current_angle = 0
        self.dest = 20 * (360/39)
        self.started = False

        self.move_start = None   # angle where the current move began
        self.move_distance = 0   # shortest signed travel for the current move
        self.move_progress = 0   # 0..1 through the current move

    def rotate_to(self, degree: float, deltatime) -> bool:
        # first frame of a move: record where it starts and how far it goes
        if self.move_start is None:
            self.move_start = self.current_angle
            self.move_distance = (degree - self.current_angle + 180) % 360 - 180
            self.move_progress = 0

        # a move takes 30 seconds regardless of frame rate
        self.move_progress = min(self.move_progress + deltatime / 3000, 1.0)
        eased = self.move_progress * self.move_progress * self.move_progress * self.move_progress

        if self.move_progress >= 1.0:
            self.current_angle = degree % 360
            self.move_start = None
            return True

        self.current_angle = (self.move_start + self.move_distance * eased) % 360
        return False

    def update(self, deltatime_in_ms):
        self.elapsed_time += deltatime_in_ms

        if self.started == True:
            if self.rotate_to(self.dest, deltatime_in_ms):
                self.started = False
                return

        # set when to start
        if ((self.elapsed_time % 1500) == 0) and self.started == False:
            self.started = True

    def draw(self, surface: pygame.Surface):
        inner_ring = pygame.transform.rotozoom(self.images[1], self.current_angle, 1)
        surface.blit(inner_ring, inner_ring.get_rect(
            center=(
                self.provided_rect.x + (self.provided_rect.width // 2), 
                self.provided_rect.y + (self.provided_rect.height // 2)
            )
        ))

        stargate = self.images[0]
        surface.blit(stargate, stargate.get_rect(
            center=(
                self.provided_rect.x + (self.provided_rect.width // 2), 
                self.provided_rect.y + (self.provided_rect.height // 2)
            )
        ))
