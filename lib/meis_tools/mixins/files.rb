module Meis::Files
  def ensure_dir(path)
    unless Dir.exist?(path)
      return FileUtils::makedirs(path).include?(path) rescue false
    end
    false
  end

  def home_path(file = nil)
    return Dir.home unless file
    File.join(Dir.home, file)
  end

  def read_file(filename)
    return nil unless File.exist?(filename)
    file = File.expand_path(filename)
    file = File.open(filename, 'r')
    data = file.read
    file.close
    data
  end

  def save_to_file(filename, data)
    File.open(filename, 'w') { |file| file.write data }
  end
end
