#! /usr/bin/ruby

require "rmagick"


def report_photo_colors()
  image = Magick::ImageList.new("imagem_desafio.jpeg")
  q = image.quantize(256, Magick::RGBColorspace)
  palette = q.color_histogram.sort {|a, b| b[1] <=> a[1]}
  total_depth = image.columns * image.rows
  report = []

  palette.count.times do |i|
    p = palette[i]

    r1 = p[0].red / 256
    g1 = p[0].green / 256
    b1 = p[0].blue / 256
    rgb = "#{r1},#{g1},#{b1}"

    quantity = p[1]

    report << {
      rgb: rgb,
      percent: ((quantity.to_f / total_depth.to_f) * 100).round(2),
      quantity: quantity
    }
  end

  return report
end


def write_result(red_points, report)
  points = red_points.nil? ? 0 : red_points[:quantity]
  File.open('result.txt', 'a') do |file|
    file.puts "There are/is #{points} red points in image"
    file.puts "The full report is: \n"
    file.puts(report)
  end
end


def main()
  rgb_color = "255,0,0"
  report = report_photo_colors()
  red_points =  report.detect {|x| x[:rgb] == rgb_color}
  write_result red_points, report
end


main
