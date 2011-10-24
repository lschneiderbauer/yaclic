module Yaclic
class Index < Hash

	def to_s
		str = ""
		self.each do |sym, ep|
			str << "#{sym}".rjust(10).bold.cyan + " | ".blue + "#{ep.operation}\n"
		end

		return str
	end

end
end
