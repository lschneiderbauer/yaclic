def debug(text,level=0)
	s = ""; level.times{ s << "\t" }
	puts "(debug) #{s}#{text}"
end
