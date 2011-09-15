def debug(text,level=0)
	if $DEBUG
		s = ""; level.times{ s << "\t" }
		puts "(debug) #{s}#{text}"
	end
end
