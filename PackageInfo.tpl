name			$(NAME)
version			$(VERSION)-1
architecture	$(ARCH)
summary 		"Konsole Tracker Add-on"
description 	"Opens /bin/konsole in the current directory."
packager		"ablyss <jb@epluribusunix.net>"
vendor			"ablyss AI assisted project"
licenses {
	"MIT"
}
copyrights {
	"$(YEAR) ablyss"
}
provides {
	$(NAME) = $(VERSION)-1
}
requires {
	haiku
}	
urls {
	"https://github.com/ablyssx74/Haiku-OS-Konsole-Tracker-Add-on"
}
source-urls {
# Download
	"https://github.com/ablyssx74/Haiku-OS-Konsole-Tracker-Add-on/archive/refs/tags/v.1.0.0.tar.gz"
}
