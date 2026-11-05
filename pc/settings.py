from dataclasses import dataclass

@dataclass
class Settings:
    background_color: str = "#05080D"
    border_color:     str = "#0E2A35"

settings = Settings()