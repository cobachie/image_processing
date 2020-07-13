# require 'gdk_pixbuf2'
# require 'cairo'
require 'gdk3'

base_image = 'images/lena.png'

# Pixbuf でリサイズ
# pixbuf = GdkPixbuf::Pixbuf.new(file: base_image, width: 100, height: 100)
# pixbuf.save('images/lena-100-cairo.png')
#
# pixbuf_l = pixbuf.scale(512, 512)
# pixbuf_l.save('images/lena-512-cairo.png')

pixbuf = Gdk::Pixbuf.new(file: base_image, width: 100, height: 100)

width = 500
height = 500

Cairo::ImageSurface.new(width, height) do |surface|
  context = Cairo::Context.new(surface)

  context.scale(surface.width / pixbuf.width, surface.height / pixbuf.height)
  context.set_source_pixbuf(pixbuf)
  context.paint

  surface.write_to_png('images/output-cairo.png')
end
