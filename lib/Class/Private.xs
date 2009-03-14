#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

MODULE = Class::Private				PACKAGE = Class::Private

PROTOTYPES: DISABLED

SV*
new(SV* name)
	CODE:
		HV* hash = newHV();
		sv_magicext((SV*)hash, sv_2mortal((SV*)newHV()), PERL_MAGIC_ext, NULL, NULL, 0);
		RETVAL = sv_bless(newRV_noinc((SV*)hash), gv_stashsv(name, GV_ADD));
	OUTPUT:
		RETVAL

SV*
_get_hash(arg, ...)
	SV* arg;
	OVERLOAD: %{}
	CODE:
		MAGIC* magic;
		if (!SvROK(arg) || SvMAGICAL(SvRV(arg)) || ((magic = mg_find(SvRV(arg), PERL_MAGIC_ext)) == NULL))
			Perl_croak(aTHX_ "Hash has no private magic!");
		const char* key = CopSTASHPV(PL_curcop);
		STRLEN keylen = strlen(key);
		SV** val = hv_fetch((HV*)magic->mg_obj, key, keylen, TRUE);
		if (!SvOK(*val))
			sv_replace(*val, newRV_noinc((SV*)newHV()));
		ST(0) = *val;
