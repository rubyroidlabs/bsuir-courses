require 'fileutils'
require 'asciiart'

FRAMES_DIR = 'frames/'
FRAME_NAME = 'frame%i.jpg'

def create_frames(gif_filename)
  puts('Processing animation frames..')
  frames = Magick::Image.read(gif_filename)
  frames_count = frames.size
  FileUtils.rm_rf(FRAMES_DIR)
  FileUtils.mkdir_p(FRAMES_DIR)
  (0...frames_count).each do |i|
    frames[i].write(FRAMES_DIR + FRAME_NAME % i)
  end
  frames_count
end

def convert_frame_to_ascii(frames_count)
  frames_in_ascii = []
  (0...frames_count).each do |i|
    new_frame = AsciiArt.new(FRAMES_DIR + FRAME_NAME % i)
    new_frame_in_ascii = new_frame.to_ascii_art(width: 80)
    frames_in_ascii.push(new_frame_in_ascii)
  end
  FileUtils.rm_rf(FRAMES_DIR)
  frames_in_ascii
end

def render_frames(frames_in_ascii, frames_count)
  (0..10).each do
    (0...frames_count).each do |i|
      puts(frames_in_ascii[i])
      sleep(0.1)
      puts("\e[H\e[2J")
    end
  end
end

def animate_gif(gif_filename)
  frames_count = create_frames(gif_filename)
  frames_in_ascii = convert_frame_to_ascii(frames_count)
  render_frames(frames_in_ascii, frames_count)
end
