# ref: https://magazine.rubyist.net/articles/0019/0019-cairo.html

require 'cairo'

width = 300
height = 200
radius = height / 3 # 半径
font_size = 16

Cairo::ImageSurface.new(:argb32, width, height) do |surface|
  context = Cairo::Context.new(surface)

  # 背景
  context.fill do
    context.set_source_rgb(1, 1, 1)
    context.rectangle(0, 0, width, height)
  end

  # 赤丸
  context.fill do
    context.set_source_color('#d7003a')
    # context.arc(width / 2, height / 2, radius, 0, 2 * Math::PI)
    context.circle(width / 2, height / 2, radius)
  end

  # 文字
  context.set_source_rgb(1, 1, 1)
  # see: https://qiita.com/scivola/items/74df8d55660d813f40e6
  context.move_to (width / 2 - font_size * 0.88), height / 2 #, font_size * 0.88
  context.set_font_size font_size
  context.show_text "123"

  surface.write_to_png("images/hinomaru.png")
end
