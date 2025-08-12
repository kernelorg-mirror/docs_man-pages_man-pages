# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_BLANK_INCLUDED
MAKEFILE_LINT_MAN_BLANK_INCLUDED := 1


include $(MAKEFILEDIR)/build/man/man.mk
include $(MAKEFILEDIR)/build/man/mdoc.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/cat.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/echo.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk


_XFAIL_LINT_man_blank := \
	$(_MANDIR)/man7/bpf-helpers.7.lint-man.blank.touch


_LINT_man_blank := $(patsubst %, %.lint-man.blank.touch, $(_NONSO_MAN) $(_NONSO_MDOC))
ifeq ($(SKIP_XFAIL),yes)
_LINT_man_blank := $(filter-out $(_XFAIL_LINT_man_blank), $(_LINT_man_blank))
endif


$(_LINT_man_blank): %.lint-man.blank.touch: % $(MK) | $$(@D)/
	$(info	$(INFO_)GREP		$@)
	$(CAT) <$< \
	| if $(GREP) '^$$' >/dev/null; then \
		>&2 $(ECHO) "lint-man-blank: $<: spurious blank lines:"; \
		>&2 $(GREP) -nT '^$$' <$<; \
		exit 1; \
	fi;
	$(TOUCH) $@


.PHONY: lint-man-blank
lint-man-blank: $(_LINT_man_blank);


endif  # include guard
