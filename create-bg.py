#!/usr/bin/env python

from PIL import Image

img = Image.new('RGB', (2, 1), 'white')
img.save('pics/white.png')

img = Image.new('RGB', (2, 1), 'black')
img.save('pics/black.png')
