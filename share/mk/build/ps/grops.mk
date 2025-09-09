# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_PS_GROPS_INCLUDED
MAKEFILE_BUILD_PS_GROPS_INCLUDED := 1


include $(MAKEFILEDIR)/build/ps/troff.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/grops.mk


_PSMAN := $(patsubst %.ps.set, %.ps, $(_PSMAN_set))


$(_PSMAN): %.ps: %.ps.set $(MK) | $$(@D)/
	$(info	$(INFO_)GROPS		$@)
	$(GROPS) $(GROPSFLAGS_) <$< >$@


.PHONY: build-ps-grops
build-ps-grops: $(_PSMAN);


endif  # include guard
