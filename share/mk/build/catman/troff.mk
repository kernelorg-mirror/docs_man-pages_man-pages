# Copyright, the authors of the Linux man-pages project
# SPDX-License-Identifier: LGPL-3.0-only WITH LGPL-3.0-linking-exception


ifndef MAKEFILE_BUILD_CATMAN_TROFF_INCLUDED
MAKEFILE_BUILD_CATMAN_TROFF_INCLUDED := 1


include $(MAKEFILEDIR)/build/_.mk
include $(MAKEFILEDIR)/build/man/man.mk
include $(MAKEFILEDIR)/build/man/mdoc.mk
include $(MAKEFILEDIR)/configure/build-depends/coreutils/true.mk
include $(MAKEFILEDIR)/configure/build-depends/grep/grep.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/nroff.mk
include $(MAKEFILEDIR)/configure/build-depends/groff-base/troff.mk
include $(MAKEFILEDIR)/configure/xfail.mk


_XFAIL_CATMAN_set := \
	$(_MANDIR)/man2/fanotify_init.2.cat.set \
	$(_MANDIR)/man2/s390_sthyi.2.cat.set \
	$(_MANDIR)/man3/unlocked_stdio.3.cat.set \
	$(_MANDIR)/man4/console_codes.4.cat.set \
	$(_MANDIR)/man4/lirc.4.cat.set \
	$(_MANDIR)/man5/proc_pid_smaps.5.cat.set \
	$(_MANDIR)/man5/tzfile.5.cat.set \
	$(_MANDIR)/man7/address_families.7.cat.set \
	$(_MANDIR)/man7/ascii.7.cat.set \
	$(_MANDIR)/man7/bpf-helpers.7.cat.set \
	$(_MANDIR)/man7/charsets.7.cat.set \
	$(_MANDIR)/man7/iso_8859-1.7.cat.set \
	$(_MANDIR)/man7/iso_8859-2.7.cat.set \
	$(_MANDIR)/man7/iso_8859-3.7.cat.set \
	$(_MANDIR)/man7/iso_8859-4.7.cat.set \
	$(_MANDIR)/man7/iso_8859-5.7.cat.set \
	$(_MANDIR)/man7/iso_8859-6.7.cat.set \
	$(_MANDIR)/man7/iso_8859-7.7.cat.set \
	$(_MANDIR)/man7/iso_8859-8.7.cat.set \
	$(_MANDIR)/man7/iso_8859-9.7.cat.set \
	$(_MANDIR)/man7/iso_8859-10.7.cat.set \
	$(_MANDIR)/man7/iso_8859-11.7.cat.set \
	$(_MANDIR)/man7/iso_8859-13.7.cat.set \
	$(_MANDIR)/man7/iso_8859-14.7.cat.set \
	$(_MANDIR)/man7/iso_8859-15.7.cat.set \
	$(_MANDIR)/man7/iso_8859-16.7.cat.set \
	$(_MANDIR)/man7/vdso.7.cat.set \
	$(_MANDIR)/man8/tzselect.8.cat.set \
	$(_MANDIR)/man8/zdump.8.cat.set \
	$(_MANDIR)/man8/zic.8.cat.set


troff_catman_ignore_grep := $(MAKEFILEDIR)/build/catman/troff.ignore.grep


_CATMAN_set := $(patsubst %, %.cat.set, $(_NONSO_MAN) $(_NONSO_MDOC))


ifeq ($(SKIP_XFAIL),yes)
_CATMAN_set := $(filter-out $(_XFAIL_CATMAN_set), $(_CATMAN_set))
endif


$(_CATMAN_set): %.cat.set: %.cat.troff $(troff_catman_ignore_grep) $(MK) | $$(@D)/
	$(info	$(INFO_)TROFF		$@)
	! ($(TROFF) -mandoc $(TROFFFLAGS_) $(NROFFFLAGS_) <$< 2>&1 >$@ \
	   | $(GREP) -v -f '$(troff_catman_ignore_grep)' \
	   || $(TRUE); \
	) \
	| $(GREP) ^ >&2


.PHONY: build-catman-troff
build-catman-troff: $(_CATMAN_set);


endif  # include guard
