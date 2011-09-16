def debug(text,level=0)
	if true
		s = ""; level.times{ s << "\t" }

		File.open("/tmp/yac_debug","a") do |f|
			f.puts "(debug) #{s}#{text}"
		end
	end
end
