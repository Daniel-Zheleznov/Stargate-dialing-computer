from dataclasses import dataclass

@dataclass
class Settings:
    padding_x:        int = 10
    padding_y:        int = 30

    background_color: str = "#05080D"
    border_color:     str = "#0E2A35"
    
    border_width:     int = 2

settings = Settings()