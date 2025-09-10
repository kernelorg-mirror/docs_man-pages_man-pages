# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_SH_SHELLCHECK_INCLUDED
MAKEFILE_LINT_SH_SHELLCHECK_INCLUDED := 1


include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/shellcheck/shellcheck.mk
include $(MAKEFILEDIR)/src/sh.mk


tgts := $(patsubst $(SRCBINDIR)/%, $(builddir)/%.lint-sh.shellcheck.touch, $(BIN_sh))


$(tgts): $(builddir)/%.lint-sh.shellcheck.touch: $(SRCBINDIR)/% $(SHELLCHECK_CONF) $(MK) | $$(@D)/
	$(info	$(INFO_)SHELLCHECK	$@)
	$(SHELLCHECK) $(SHELLCHECKFLAGS_) $<
	$(TOUCH) $@


.PHONY: lint-sh-shellcheck
lint-sh-shellcheck: $(tgts);


undefine tgts


endif  # include guard
