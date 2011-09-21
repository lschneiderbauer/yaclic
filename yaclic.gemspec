require 'rake'

Gem::Specification.new do |s|

	s.name		=	'yaclic'
	s.version	=	'1'
	s.date		=	'2011-09-19'
	s.summary	=	"Yet another cli calculator"
	s.authors	=	["Lukas Schneiderbauer"]
	s.email		=	'lukas.schneiderbauer@gmail.com'
	s.files		=	FileList["lib/yaclic/*.rb","lib/*.rb","bin/*","test/*"].to_a
	s.homepage	=	"https://github.com/vootey/yaclic"

end
