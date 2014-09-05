install_deb:
	/bin/bash deb.sh

install_all: install_deb
	/bin/bash extra.sh
	/bin/bash user.sh
	/bin/bash luks.sh
	/bin/bash data.sh
	/bin/bash git.sh

update_all:
	/bin/bash deb.sh -ua

update_tty:
	/bin/bash deb.sh -ut

update_x:
	/bin/bash deb.sh -ux

