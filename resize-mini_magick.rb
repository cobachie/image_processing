require "mini_magick"

image = MiniMagick::Image.open('images/lena.png')
image.resize '100x100'
image.format 'png'

image.resize '512x512'
image.format 'png'
image.write 'images/output-minimagick.png'
