require 'rake'

Gem::Specification.new do |s|

	s.name		=	'yac'
	s.version	=	'1'
	s.date		=	'2011-09-19'
	s.summary	=	"Yet another calculator"
	s.authors	=	["Lukas Schneiderbauer"]
	s.email		=	'lukas.schneiderbauer@gmail.com'
	s.files		=	FileList["lib/*.rb","bin/*","test/*"].to_a
	s.homepage	=	"https://github.com/vootey/yac"

end
