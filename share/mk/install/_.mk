# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_INSTALL_INCLUDED
MAKEFILE_INSTALL_INCLUDED ::= 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils/install.mk


%/:
	+$(info	$(INFO_)MKDIR		$@)
	+$(INSTALL_DIR) $@


.PHONY: install-all
install-all: install-man install-bin;

.PHONY: install
install: install-man install-bin;


endif  # include guard
