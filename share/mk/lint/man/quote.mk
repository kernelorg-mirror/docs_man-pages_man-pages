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


ext := .lint-man.quote.touch
xfail := $(MAKEFILEDIR)/lint/man/quote.xfail

tgts := $(patsubst %, %$(ext), $(_NONSO_MAN) $(_NONSO_MDOC))
ifeq ($(SKIP_XFAIL),yes)
tgts := $(filter-out $(patsubst %, $(_MANDIR)/%$(ext), $(file < $(xfail))), $(tgts))
endif


quote_Pgrep := $(MAKEFILEDIR)/lint/man/quote.Pgrep


$(tgts): %.lint-man.quote.touch: % $(quote_Pgrep) $(MK) | $$(@D)/
	$(info	$(INFO_)GREP		$@)
	$(CAT) <$< \
	| if $(GREP) -Pf $(quote_Pgrep) >/dev/null; then \
		>&2 $(ECHO) "lint-man-quote: $<: Unmatched quote:"; \
		>&2 $(GREP) -PTnf '$(quote_Pgrep)' <$<; \
		exit 1; \
	fi;
	$(TOUCH) $@


.PHONY: lint-man-quote
lint-man-quote: $(tgts);


undefine ext
undefine xfail
undefine tgts


endif  # include guard
