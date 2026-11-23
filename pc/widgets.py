import pygame
import random

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

        # pad the inner ring to an even square with its center on the pivot,
        # so rotation always turns around the same point
        inner_ring_src = self.images[1]
        inner_ring = pygame.Surface((366, 366), pygame.SRCALPHA)
        inner_ring.blit(inner_ring_src, (1, 1))
        self.images[1] = inner_ring

        self.current_angle = 0
        self.dest = 20 * (360/39)
        self.gate_status = "idle"
        self.gate_image = 0
        self.gate_goto_glyph = 1
        self.hold_elapsed = 0    # ms spent on the current locked frame

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

        if self.move_progress >= 1.0:
            self.current_angle = degree % 360
            self.move_start = None
            return True

        # constant speed for the first 80% of the move, then a smooth stop over the last 20%
        # (speed matches at the join and reaches zero at the target, so there is no abrupt end)
        t = self.move_progress
        decel_start = 0.8
        if t <= decel_start:
            fraction = t
        else:
            u = (t - decel_start) / (1 - decel_start)
            fraction = decel_start + (1 - decel_start) * (u + u * u - u * u * u)

        self.current_angle = (self.move_start + self.move_distance * fraction) % 360
        return False

    def update(self, deltatime_in_ms):
        self.elapsed_time += deltatime_in_ms

        # change render image for gate and when to start
        match self.gate_status.lower():
            case "idle":
                if ((self.elapsed_time % 1500) == 0):
                    self.gate_status = "dialing"
                    self.gate_image = 2
                    self.gate_goto_glyph = (self.gate_goto_glyph - 1 + random.randint(10, 29)) % 39 + 1

            case "dialing":
                if self.gate_image % 2 == 0:
                    # locking frame: turn the ring, then show the locked frame on arrival
                    direction = random.choice([-1, 1])
                    glyph_angle = self.gate_goto_glyph * (360 / 39) * direction
                    if self.rotate_to(glyph_angle, deltatime_in_ms):
                        self.gate_image += 1
                        self.hold_elapsed = 0
                else:
                    # locked frame: hold for 1.5 s, then go to the next locking frame
                    self.hold_elapsed += deltatime_in_ms
                    if self.hold_elapsed >= 750 and self.gate_image < 15:
                        self.gate_image += 1
                        self.gate_goto_glyph = (self.gate_goto_glyph - 1 + random.randint(10, 39)) % 39 + 1
                    
                    if self.gate_image >= 15:
                        self.gate_status = "active"

            case "active":
                pass

    def draw(self, surface: pygame.Surface):
        inner_ring = pygame.transform.rotozoom(self.images[1], self.current_angle, 1)
        surface.blit(inner_ring, inner_ring.get_rect(
            center=(
                self.provided_rect.x + (self.provided_rect.width // 2), 
                self.provided_rect.y + (self.provided_rect.height // 2)
            )
        ))

        stargate = self.images[self.gate_image]
        surface.blit(stargate, stargate.get_rect(
            center=(
                self.provided_rect.x + (self.provided_rect.width // 2), 
                self.provided_rect.y + (self.provided_rect.height // 2)
            )
        ))
