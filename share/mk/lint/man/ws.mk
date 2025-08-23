# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_LINT_MAN_WS_INCLUDED
MAKEFILE_LINT_MAN_WS_INCLUDED := 1


include $(MAKEFILEDIR)/build/man/man.mk
include $(MAKEFILEDIR)/build/man/mdoc.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/cat.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/echo.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/touch.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk


_XFAIL_LINT_man_ws := \
	$(_MANDIR)/man7/bpf-helpers.7.lint-man.ws.touch


_LINT_man_ws := $(patsubst %, %.lint-man.ws.touch, $(_NONSO_MAN) $(_NONSO_MDOC))
ifeq ($(SKIP_XFAIL),yes)
_LINT_man_ws := $(filter-out $(_XFAIL_LINT_man_ws), $(_LINT_man_ws))
endif


ws_egrep := $(MAKEFILEDIR)/lint/man/ws.egrep


$(_LINT_man_ws): %.lint-man.ws.touch: % $(ws_egrep) $(MK) | $$(@D)/
	$(info	$(INFO_)GREP		$@)
	$(CAT) <$< \
	| if $(GREP) -Ef $(ws_egrep) >/dev/null; then \
		>&2 $(ECHO) "lint-man-ws: $<: Spurious white space:"; \
		>&2 $(GREP) -ETnf '$(ws_egrep)' <$<; \
		exit 1; \
	fi;
	$(TOUCH) $@


.PHONY: lint-man-ws
lint-man-ws: $(_LINT_man_ws);


endif  # include guard
