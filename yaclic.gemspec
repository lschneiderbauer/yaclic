require 'rake'

Gem::Specification.new do |s|

	s.name		=	'yaclic'
	s.version	=	'3'
	s.date		=	'2011-09-23'
	s.summary	=	"Yet another cli calculator"
	s.authors	=	["Lukas Schneiderbauer"]
	s.email		=	'lukas.schneiderbauer@gmail.com'
	s.files		=	FileList["lib/yaclic/operators/*.rb","lib/yaclic/*.rb","lib/*.rb","bin/*","test/*"].to_a
	s.homepage	=	"http://vootey.github.com/yaclic/"

end
