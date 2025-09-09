# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_PS_TROFF_INCLUDED
MAKEFILE_BUILD_PS_TROFF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/man/man.mk
include $(MAKEFILEDIR)/build/man/mdoc.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/troff.mk
include $(MAKEFILEDIR)/configure/xfail.mk


_XFAIL_PSMAN_set := \
	$(_MANDIR)/man1/iconv.1.ps.set \
	$(_MANDIR)/man2/fanotify_init.2.ps.set \
	$(_MANDIR)/man2/membarrier.2.ps.set \
	$(_MANDIR)/man2/prctl.2.ps.set \
	$(_MANDIR)/man2/statx.2.ps.set \
	$(_MANDIR)/man2/syscall.2.ps.set \
	$(_MANDIR)/man3/newlocale.3.ps.set \
	$(_MANDIR)/man7/address_families.7.ps.set \
	$(_MANDIR)/man7/armscii-8.7.ps.set \
	$(_MANDIR)/man7/ascii.7.ps.set \
	$(_MANDIR)/man7/bpf-helpers.7.ps.set \
	$(_MANDIR)/man7/charsets.7.ps.set \
	$(_MANDIR)/man7/cp1251.7.ps.set \
	$(_MANDIR)/man7/iso_8859-2.7.ps.set \
	$(_MANDIR)/man7/iso_8859-3.7.ps.set \
	$(_MANDIR)/man7/iso_8859-4.7.ps.set \
	$(_MANDIR)/man7/iso_8859-5.7.ps.set \
	$(_MANDIR)/man7/iso_8859-6.7.ps.set \
	$(_MANDIR)/man7/iso_8859-7.7.ps.set \
	$(_MANDIR)/man7/iso_8859-8.7.ps.set \
	$(_MANDIR)/man7/iso_8859-10.7.ps.set \
	$(_MANDIR)/man7/iso_8859-11.7.ps.set \
	$(_MANDIR)/man7/iso_8859-13.7.ps.set \
	$(_MANDIR)/man7/iso_8859-14.7.ps.set \
	$(_MANDIR)/man7/iso_8859-16.7.ps.set \
	$(_MANDIR)/man7/koi8-r.7.ps.set \
	$(_MANDIR)/man7/koi8-u.7.ps.set \
	$(_MANDIR)/man7/pathname.7.ps.set \
	$(_MANDIR)/man7/vdso.7.ps.set


_PSMAN_set  := $(patsubst %, %.ps.set, $(_NONSO_MAN) $(_NONSO_MDOC))


ifeq ($(SKIP_XFAIL),yes)
_PSMAN_set := $(filter-out $(_XFAIL_PSMAN_set), $(_PSMAN_set))
endif


$(_PSMAN_set): %.ps.set: %.ps.troff $(MK) | $$(@D)/
	$(info	$(INFO_)TROFF		$@)
	! ($(TROFF) -mandoc -Tps $(TROFFFLAGS_) <$< 2>&1 >$@) \
	| $(GREP) ^ >&2


.PHONY: build-ps-troff
build-ps-troff: $(_PSMAN_set);


endif  # include guard
