# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_IWYU_INCLUDED
MAKEFILE_LINT_C_IWYU_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/clang/clang.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/tac.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/true.mk
include $(MAKEFILEDIR)/configure/build-depends/cpp/cpp.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/iwyu/iwyu.mk
include $(MAKEFILEDIR)/configure/build-depends/sed/sed.mk
include $(MAKEFILEDIR)/configure/xfail.mk


ext := .lint-c.iwyu.touch
xfail := $(MAKEFILEDIR)/lint/c/iwyu.xfail

tgts := $(patsubst %, %$(ext), $(_EX_TU_src))
ifeq ($(SKIP_XFAIL),yes)
tgts := $(filter-out $(patsubst %, $(_MANDIR)/%$(ext), $(file < $(xfail))), $(tgts))
endif


_LINT_c_EX_iwyu   := $(tgts)
_LINT_c_iwyu      := $(_LINT_c_EX_iwyu)


$(_LINT_c_EX_iwyu): %.lint-c.iwyu.touch: %
$(_LINT_c_iwyu): $(MK) | $$(@D)/


$(_LINT_c_iwyu):
	$(info	$(INFO_)IWYU		$@)
	! ($(IWYU) $(IWYUFLAGS_) $(CLANGFLAGS_) $(CPPFLAGS_) $< 2>&1 \
	   | $(SED) -n '/should add these lines:/,$$p' \
	   | $(TAC) \
	   | $(SED) '/correct/{N;d}' \
	   | $(TAC) \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2
	$(TOUCH) $@


.PHONY: lint-c-iwyu
lint-c-iwyu: $(_LINT_c_iwyu);


undefine ext
undefine xfail
undefine tgts


endif  # include guard
