require "reduce"

def minify?
  if Jekyll.env != "development" and Jekyll.configuration["s3_deploy"]
    Jekyll.configuration["s3_deploy"]["minify"]
  end
end

def compress?
  if Jekyll.env != "development" and Jekyll.configuration["s3_deploy"]
    Jekyll.configuration["s3_deploy"]["compress"]
  end
end

def gzip(data)
  sio = StringIO.new
  gz = Zlib::GzipWriter.new(sio)
  gz.write(data)
  gz.close
  sio.string
end

Jekyll::Hooks.register :site, :post_write do |site|
  Dir.glob("#{Jekyll.configuration["destination"]}/**/*.*") do |file|
    case File.extname(file)
    when ".css", ".js", ".html", ".xml"
      result = File.read file
      result = Reduce.reduce(file) if minify?
      result = gzip(result) if compress?
      File.open(file, "w") do |f|
        f.write(result)
      end
    when ".jpg", ".jpeg", ".gif", ".png"
      result = file
      result = Reduce.reduce(file) if minify?
      result = gzip(result) if compress?
      File.open(file, "w") do |f|
        f.write(result)
      end
    end
  end
end
