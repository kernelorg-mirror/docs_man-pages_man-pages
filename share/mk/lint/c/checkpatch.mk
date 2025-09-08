# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CHECKPATCH_INCLUDED
MAKEFILE_LINT_C_CHECKPATCH_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/checkpatch/checkpatch.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/xfail.mk


ext := .lint-c.checkpatch.touch
xfail := $(MAKEFILEDIR)/lint/c/iwyu.xfail

tgts := $(patsubst %, %$(ext), $(_EX_TU_src))
ifeq ($(SKIP_XFAIL),yes)
tgts := $(filter-out $(patsubst %, $(_MANDIR)/%$(ext), $(file < $(xfail))), $(tgts))
endif


_LINT_c_EX_checkpatch   := $(tgts)
_LINT_c_checkpatch      := $(_LINT_c_EX_checkpatch)


$(_LINT_c_EX_checkpatch): %.lint-c.checkpatch.touch: %
$(_LINT_c_checkpatch): $(CHECKPATCH_CONF) $(MK) | $$(@D)/


$(_LINT_c_checkpatch):
	$(info	$(INFO_)CHECKPATCH	$@)
	$(CHECKPATCH) $(CHECKPATCHFLAGS_) -f $< >&2
	$(TOUCH) $@


.PHONY: lint-c-checkpatch
lint-c-checkpatch: $(_LINT_c_checkpatch);


undefine ext
undefine xfail
undefine tgts


endif  # include guard
