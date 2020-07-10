# ref: https://stackoverflow.com/questions/14580033/algorithm-for-drawing-a-5-point-star

require 'cairo'

def rotate(vecArr, byRads)
  mat = [
      [Math.cos(byRads), -Math.sin(byRads)],
      [Math.sin(byRads), Math.cos(byRads)]
  ]

  result = []
  (0...vecArr.length).each do |i|
    result[i] = [
        mat[0][0] * vecArr[i][0] + mat[0][1] * vecArr[i][1],
        mat[1][0] * vecArr[i][0] + mat[1][1] * vecArr[i][1]
    ]
  end

  result
end

# draw 5 points star
def draw_star(radius)
  points = 5
  triangle_base = radius * Math.tan(Math::PI / points)
  triangle = [
      [0, radius],
      [triangle_base / 2, 0],
      [-triangle_base / 2, 0],
      [0, radius]
  ]

  result = []
  (0...points).each do |i|
    result[i] = rotate(triangle, i * (2 * Math::PI / points))
  end

  result
end

def draw_object(context, object, offset, flipVert)
  sign = flipVert ? -1 : 1
  offset_x, offset_y = offset[0], offset[1]

  (0...object.length).each do |i|
    elem = object[i]
    context.move_to(elem[0][0] + offset_x, sign * elem[0][1] + offset_y)

    (1...elem.length).each do |j|
      context.line_to(elem[j][0] + offset_x, sign * elem[j][1] + offset_y)
    end
  end
end


width = 300
height = 300
radius = height / 3 # 半径

Cairo::ImageSurface.new(:argb32, width, height) do |surface|
  context = Cairo::Context.new(surface)

  context.fill do
    context.set_source_color('#eb4d4b')
    # context.set_line_width(10)

    offset = [width / 2, height / 2];
    star = draw_star(radius)
    draw_object(context, star, offset, true);
  end

  surface.write_to_png("images/star.png")
end

