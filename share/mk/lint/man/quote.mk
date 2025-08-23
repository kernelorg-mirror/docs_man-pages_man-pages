# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_QUOTE_INCLUDED
MAKEFILE_LINT_MAN_QUOTE_INCLUDED := 1


include $(MAKEFILEDIR)/build/man/man.mk
include $(MAKEFILEDIR)/build/man/mdoc.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/cat.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/echo.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk


_XFAIL_LINT_man_quote := \
	$(_MANDIR)/man8/tzselect.8.lint-man.quote.touch \
	$(_MANDIR)/man8/zic.8.lint-man.quote.touch


_LINT_man_quote := $(patsubst %, %.lint-man.quote.touch, $(_NONSO_MAN) $(_NONSO_MDOC))
ifeq ($(SKIP_XFAIL),yes)
_LINT_man_quote := $(filter-out $(_XFAIL_LINT_man_quote), $(_LINT_man_quote))
endif


quote_Pgrep := $(MAKEFILEDIR)/lint/man/quote.Pgrep


$(_LINT_man_quote): %.lint-man.quote.touch: % $(quote_Pgrep) $(MK) | $$(@D)/
	$(info	$(INFO_)GREP		$@)
	$(CAT) <$< \
	| if $(GREP) -Pf $(quote_Pgrep) >/dev/null; then \
		>&2 $(ECHO) "lint-man-quote: $<: Unmatched quote:"; \
		>&2 $(GREP) -PTnf '$(quote_Pgrep)' <$<; \
		exit 1; \
	fi;
	$(TOUCH) $@


.PHONY: lint-man-quote
lint-man-quote: $(_LINT_man_quote);


endif  # include guard
