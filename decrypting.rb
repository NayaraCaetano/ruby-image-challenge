#! /usr/bin/ruby

require "rmagick"


def decrypting()
  image = Magick::Image.read("imagem_desafio.png").first
  image = image.quantize(500)
  palette = image.color_histogram.sort {|a, b| b[1] <=> a[1]}
  pixel_red = Magick::Pixel.from_color("red")

  palette.count.times do |i|
    pixel = palette[i][0]
    if !pixel.fcmp(pixel_red)
      image = image.transparent(pixel)
    end
  end

  image.write('result.png')
end


def main()
  report = decrypting()
end


main
