# https://upload.wikimedia.org/wikipedia/commons/e/e6/StargateGlyph01.svg

#import requests 

#glyphs = [
#    "https://upload.wikimedia.org/wikipedia/commons/e/e6/StargateGlyph01.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/d/d4/StargateGlyph02.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/7/77/StargateGlyph03.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/8/8b/StargateGlyph04.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/0/0f/StargateGlyph05.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/6/62/StargateGlyph06.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/f/fc/StargateGlyph07.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/5/53/StargateGlyph08.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/4/4e/StargateGlyph09.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/0/07/StargateGlyph10.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/1/13/StargateGlyph11.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/0/04/StargateGlyph12.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/e/e5/StargateGlyph13.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/a/ad/StargateGlyph14.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/5/52/StargateGlyph15.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/8/89/StargateGlyph16.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/a/a4/StargateGlyph17.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/e/ed/StargateGlyph18.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/8/81/StargateGlyph19.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/b/b8/StargateGlyph20.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/4/43/StargateGlyph21.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/3/38/StargateGlyph22.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/3/33/StargateGlyph23.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/b/bf/StargateGlyph24.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/1/1e/StargateGlyph25.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/7/78/StargateGlyph26.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/e/e2/StargateGlyph27.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/6/66/StargateGlyph28.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/3/31/StargateGlyph29.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/d/da/StargateGlyph30.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/5/53/StargateGlyph31.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/0/08/StargateGlyph32.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/c/c7/StargateGlyph33.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/8/86/StargateGlyph34.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/6/6c/StargateGlyph35.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/3/38/StargateGlyph36.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/9/96/StargateGlyph37.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/c/cf/StargateGlyph38.svg",
#    "https://upload.wikimedia.org/wikipedia/commons/6/6c/StargateGlyph39.svg"
#]

#for count, i in enumerate(glyphs):
#    content = requests.get(i, headers={"User-Agent": "StargateImageDownloadBot/0.0 (daniel.zheleznov@gmail.com) py-requests-stargate-image-download"}).text

#    with open("C:\\Dev\\Roku-Screensaver-SGC\\my_code\\images\\Glyphs\\glyph_svg" + str(count) + ".svg", "x+") as file:
#        file.write("".join(content))

#        file.close()

import os
import cairosvg

for count, file in enumerate(os.listdir()):
    if file.__contains__("glyph"):
            cairosvg.svg2png(
                url="C:\\Dev\\Roku-Screensaver-SGC\\my_code\\images\\Glyphs\\"+file, 
                write_to=f"C:\\Dev\\Roku-Screensaver-SGC\\my_code\\images\\Glyphs\\glyph{count+1}.png", 
                output_width=16, output_height=16
            )