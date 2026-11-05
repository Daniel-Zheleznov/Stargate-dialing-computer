import pygame

class Widget:
    def __init__(self, settings, provided_rect):
        self.settings = settings
        self.rect = provided_rect

    def update(self, deltatime):
        pass

    def draw(self, surface):
        raise NotImplementedError