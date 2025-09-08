# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CPPCHECK_INCLUDED
MAKEFILE_LINT_C_CPPCHECK_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/cppcheck/cppcheck.mk
include $(MAKEFILEDIR)/configure/xfail.mk


ext := .lint-c.cppcheck.touch
xfail := $(MAKEFILEDIR)/lint/c/cppcheck.xfail

tgts := $(patsubst %, %$(ext), $(_EX_TU_src))
ifeq ($(SKIP_XFAIL),yes)
tgts := $(filter-out $(patsubst %, $(_MANDIR)/%$(ext), $(file < $(xfail))), $(tgts))
endif


_LINT_c_EX_cppcheck   := $(tgts)
_LINT_c_cppcheck      := $(_LINT_c_EX_cppcheck)


$(_LINT_c_EX_cppcheck): %.lint-c.cppcheck.touch: %
$(_LINT_c_cppcheck): $(CPPCHECK_SUPPRESS) $(MK) | $$(@D)/


$(_LINT_c_EX_cppcheck):
	$(info	$(INFO_)CPPCHECK	$@)
	$(CPPCHECK) $(CPPCHECKFLAGS_) $<
	$(TOUCH) $@


.PHONY: lint-c-cppcheck
lint-c-cppcheck: $(_LINT_c_cppcheck);


undefine ext
undefine xfail
undefine tgts


endif  # include guard
