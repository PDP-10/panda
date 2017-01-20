/*
 * Copyright (c) 1987,1988 Massachusetts Institute of Technology.
 *
 * Note that there is absolutely NO WARRANTY on this software.
 * See the file COPYRIGHT.NOTICE for details and restrictions.
 *
 * Name routines (see RFC883 for format). like strcpy(), strcmp(), &c.
 */

#include "domsym.h"

/*
 * namcnt() -- count tags in a name, including null tag (root).
 */

int namcnt(name)
    char *name;
{
    int i;
    if(name == NULL)
	return(0);
    for(i = 0; *name != 0; name += 1 + *name)
	++i;
    return(++i);
}

/*
 * namexp() -- explode a name into vector of tags.
 * Returns value like namcnt().
 */

int namexp(name,vector)
    char *name, **vector;
{
    int i;
    static char empty[1] = {0};
    if(name == NULL)
	return(0);
    for(i = 0; *name != 0; ++i, name += 1 + *name, ++vector)
	*vector = name;
    *vector = empty;
    return(++i);
}


/*
 * namimp() -- implode a vector of tags into a name.
 * Returns pointer to the consed name.
 */

char *namimp(vector,ntags)
    char **vector;
    int ntags;
{
    char *p, *name;
    int sum = 0, i;
    if(vector == NULL || --ntags < 0)
	return(NULL);
    for(i = 0; i < ntags; ++i)
	if(vector[i] == NULL)
	    return(NULL);
	else
	    sum += 1 + *vector[i];
    name = mak(sum+1);
    for(p = name, i = 0; i < ntags; ++i, p += 1 + *p)
	bcopy(vector[i], p, 1 + *vector[i]);
    *p = 0;
    return(name);
}

/*
 * namcmp(n1,n2)
 *
 * Compare two domain names.  Returns results like strcmp.  Does not
 * handle compression pointers, you have to expand such before calling
 * this function.
 *
 * namcmp first skips over enough tags in one or the other string that
 * the number of tags remaining is the same for both strings.  If
 * there are differences (case insensitive) in these tags, a value is
 * returned as strcmp would for simple strings.  If all the tags
 * match, the string with more tags is considered longer.  Actual work
 * of comparing tags is done by tagcmp.
 */

int namcmp(name1,name2)
    char *name1, *name2;
{
    int len1, len2, cmp;
    char *vec1[MAX_DOMAIN_TAG_COUNT+1], *vec2[MAX_DOMAIN_TAG_COUNT+1];

    len1 = namexp(name1,vec1) - 1;
    len2 = namexp(name2,vec2) - 1;
    while(len1 > 0 && len2 > 0)
	if((cmp = tagcmp(vec1[--len1],vec2[--len2])) != 0)
	    return(cmp);
    return(len1 - len2);
}

/*
 * namkin(ancestor,descendant) -- determine degree of kinship between two names
 *
 * Returns integer value, the higher the value the closer the kinship.
 * Returns negative to indicate that descendant isn't in ancestor's
 * family tree at all.
 *
 * For efficency there is some duplication of code from other routines
 * in this module, oh well.
 */

int namkin(ancestor,descendant)
    char *ancestor, *descendant;
{
    int l_ancestor, l_descendant, kinship;
    char *v_ancestor[MAX_DOMAIN_TAG_COUNT+1];
    char *v_descendant[MAX_DOMAIN_TAG_COUNT+1];

    if(ancestor == NULL || descendant == NULL)
	bughlt("namkin","bad arguments, ancestor==%o, descendant==%o",
	    ancestor,descendant);	/* well, what else should I do here? */

    l_ancestor	 = namexp(ancestor,  v_ancestor  ) - 1;
    l_descendant = namexp(descendant,v_descendant) - 1;
    if((kinship = l_ancestor) > l_descendant)
	return(-1);			/* can't possibly be ancestor */

    while(l_ancestor > 0)		/* compare like namcmp() */
	if(tagcmp(v_ancestor[--l_ancestor],v_descendant[--l_descendant]) != 0)
	    return(-1);			/* cousin, punt */

    return(kinship);			/* ancestor, return like namcnt() */
}

/*
 * Compare two tags.  Called by external routines as well as namcmp().
 */

int tagcmp(tag1,tag2)
    char *tag1, *tag2;
{
    int cmp;
    if((cmp = strnCMP(tag1+1, tag2+1, ((*tag1 < *tag2) ? *tag1 : *tag2))) != 0)
        return(cmp);
    else
	return(*tag1 - *tag2);
}

/*
 * namlen(name) -- length of a name.
 *  If name contains compression pointers you will get the length
 *  of the name up to the first compression pointer, plus two (the
 *  length of the compression pointer itself).
 */

int namlen(nam)
    char *nam;
{
    int sum = 1, c;
    while((c = *nam) != 0)
	if((c & DOM_MSK) == DOM_PTR)
	    return(++sum);
	else if((c & DOM_MSK) != 0)
	    return(0);
	else {
	    sum += (1 + c);
	    nam += (1 + c);
	}

    return(sum);
}


/*
 * namcpy(destination,source,origin) -- copy a name.
 *
 *  If origin is NULL, names can't contain compression pointers.
 *  Otherwise, origin is the zero'th byte of the "packet" containing
 *  the source string.  Results will not contain compression pointers
 *  in either case.
 *
 *  Returns first arg if won, else NULL.
 *
 *  This routine also checks that all names are of reasonable length.
 */

char *namcpy(dest,src,org)
    char *dest,*src,*org;
{
    char *result = dest;
    int c, n = 0;
    while((c = *src++) != 0)
	if((c & DOM_MSK) == DOM_PTR && org != NULL)
	    src = org + (((c & ~DOM_MSK) << 8) | (*src & 0xFF));
	else if((c&DOM_MSK) == 0) {
	    if((n += c + 1) > MAX_DOMAIN_NAME_LENGTH)
		return(NULL);
	    *dest++ = c;
	    bcopy(src,dest,c);
	    src  += c;
	    dest += c;
	}
	else				/* NULL org or bad DOM_MSK bits */
	    return(NULL);
    *dest = 0;
    return(result);			/* count null byte at end. */
}


/*
 * namcat(dest,src,org) -- append a name.  See namcpy().
 */

char *namcat(dest,src,org)
    char *dest,*src,*org;
{
    return(namcpy(dest+namlen(dest)-1,src,org) ? dest : NULL);
}

/*
 * vnamtoa(dest,vector,ntags) -- convert a name vector to ascii.
 */
char *vnamtoa(dest,vector,ntags)
    char *dest, **vector;
    int ntags;
{
    int i,j;
    char *pi, *po = dest;
    if(po == NULL || vector == NULL || ntags <= 0)
	return(NULL);
    if(--ntags == 0)
	return(strcpy(dest,"."));
    for(i = 0; i < ntags; ++i) {
	for(j = (int) *(pi = vector[i]); j > 0; --j)
	    switch(*++pi) {
		case '\0':
		    strcpy(po,"\000");
		    po += 4;
		    break;
		case '.':
		case '\\':
		    *po++ = '\\';
		default:
		    *po++ = *pi;
	    }
	*po++ = '.';
    }
    *po++ = '\0';
    return(dest);
}

/*
 * namtoa(dest,name) -- convert a name to ascii.
 */
char *namtoa(dest,name)
    char *dest,*name;
{
    char *vector[MAX_DOMAIN_TAG_COUNT+1];
    return(vnamtoa(dest,vector,namexp(name,vector)));
}
