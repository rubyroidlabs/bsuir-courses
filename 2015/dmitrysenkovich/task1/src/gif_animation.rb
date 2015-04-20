require "fileutils"
require "asciiart"

FRAMES_DIR="frames/"
FRAME_NAME="frame%i.jpg"

def animate_gif(gif_filename)
    puts("Processing animation frames..")
    frames = Magick::Image.read(gif_filename)
    frames_count = frames.size()
    frames_in_ascii = Array.new
    FileUtils.rm_rf(FRAMES_DIR)
    FileUtils.mkdir_p(FRAMES_DIR)
    (0...frames_count).each do |i|
        frames[i].write(FRAMES_DIR+FRAME_NAME%i)
        frames_in_ascii.push(AsciiArt.new(FRAMES_DIR+FRAME_NAME%i).to_ascii_art(width:80))
    end
    FileUtils.rm_rf(FRAMES_DIR)

    (0..10).each do
        (0...frames_count).each do |i|
            puts frames_in_ascii[i]
            sleep(0.1)
            puts("\e[H\e[2J")
        end
    end
end
