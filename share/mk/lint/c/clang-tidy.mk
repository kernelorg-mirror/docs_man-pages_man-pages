# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_C_CLANG_TIDY_INCLUDED
MAKEFILE_LINT_C_CLANG_TIDY_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/examples/src.mk
include $(MAKEFILEDIR)/configure/build-depends/clang/clang.mk
include $(MAKEFILEDIR)/configure/build-depends/clang-tidy/clang-tidy.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/cpp/cpp.mk
include $(MAKEFILEDIR)/configure/build-depends/sed/sed.mk
include $(MAKEFILEDIR)/configure/xfail.mk


ext := .lint-c.clang-tidy.touch
xfail := $(MAKEFILEDIR)/lint/c/clang-tidy.xfail

tgts := $(patsubst %, %$(ext), $(_EX_TU_src))
ifeq ($(SKIP_XFAIL),yes)
tgts := $(filter-out $(patsubst %, $(_MANDIR)/%$(ext), $(file < $(xfail))), $(tgts))
endif


_LINT_c_EX_clang_tidy   := $(tgts)
_LINT_c_clang_tidy      := $(_LINT_c_EX_clang_tidy)


$(_LINT_c_EX_clang_tidy): %.lint-c.clang-tidy.touch: %
$(_LINT_c_clang_tidy): $(CLANG_TIDY_CONF) $(MK) | $$(@D)/


$(_LINT_c_clang_tidy):
	$(info	$(INFO_)CLANG_TIDY	$@)
	$(CLANG_TIDY) $(CLANG_TIDYFLAGS_) $< -- $(CLANGFLAGS_) $(CPPFLAGS_) 2>&1 \
	| $(SED) '/generated\.$$/d' >&2
	$(TOUCH) $@


.PHONY: lint-c-clang-tidy
lint-c-clang-tidy: $(_LINT_c_clang_tidy);


undefine ext
undefine xfail
undefine tgts


endif  # include guard
