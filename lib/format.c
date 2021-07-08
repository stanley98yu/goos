#include "format.h"
#include "string.h"

/* Converts an integer to a null-terminated string using the specified base. */
void itoa(int n, char s[], int base)
{
	int sign, mod, i = 0;

	if ((sign = n) < 0) {
		n *= -1;
	}

	do {
		mod = n % base;
		if (mod < 10) {
			s[i++] = mod + '0';
		} else {
			s[i++] = mod - 10 + 'a';
		}
	} while ((n /= base) > 0);

	if (sign < 0) {
		s[i++] = '-';
	}

	// Base prefixes
	if (base == 2) {
		s[i++] = 'b';
		s[i++] = '0';
	} else if (base == 16) {
		s[i++] = 'x';
		s[i++] = '0';
	} else if (base < 1) {
		return;
	}

	s[i] = '\0';
	reverse(s);
}
