#include "string.h"

void *memset(void *ptr, int value, int num)
{
	char *p = ptr;

	for (int i = 0; i < num; i++) {
		*(p+i) = (char)value;
	}
	return ptr;
}

void reverse(char s[])
{
	int c, i, j;

	for (i = 0, j = strlen(s)-1; i < j; i++, j--) {
		c = s[i];
		s[i] = s[j];
		s[j] = c;
	}
}

int strlen(const char s[])
{
	int i = 0;

	while (s[i] != '\0') {
		i++;
	}
	return i;
}
