#requires and stuff go here

def load_irbrc(path)
  return if (path == ENV["HOME"]) || (path == '/')

  load_irbrc(File.dirname path)

  irbrc = File.join(path, ".irbrc")

  load irbrc if File.exists?(irbrc)
end

# other ruby code in your .irbrc

load_irbrc Dir.pwd # probably should stay at the bottom
