/* $Id: scan.l,v 1.5 2006/07/27 03:44:05 erg Exp $ $Revision: 1.5 $ */
/* vim:set shiftwidth=4 ts=8: */

/**********************************************************
*      This software is part of the graphviz package      *
*                http://www.graphviz.org/                 *
*                                                         *
*            Copyright (c) 1994-2004 AT&T Corp.           *
*                and is licensed under the                *
*            Common Public License, Version 1.0           *
*                      by AT&T Corp.                      *
*                                                         *
*        Information and Software Systems Research        *
*              AT&T Research, Florham Park NJ             *
**********************************************************/


/* requires flex (i.e. not lex)  */
%{
#include <ctype.h>
#include "grammar.h"
#include "aghdr.h"
#ifdef WIN32
#include <io.h>
#endif

#define GRAPH_EOF_TOKEN		'@'		/* lex class must be defined below */
	/* this is a workaround for linux flex */
static int line_num = 1;
static int html_nest = 0;  /* nesting level for html strings */
static char* InputFile;
static Agdisc_t	*Disc;
static void 	*Ifile;

  /* Reset line number */
void agreadline(int n) { line_num = n; }

  /* (Re)set file:
   */
void agsetfile(char* f) { InputFile = f; line_num = 1; }

/* There is a hole here, because switching channels 
 * requires pushing back whatever was previously read.
 * There probably is a right way of doing this.
 */
void aglexinit(Agdisc_t *disc, void *ifile) { Disc = disc; Ifile = ifile;}

#ifndef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ((result = Disc->io->afread(Ifile, buf, max_size)) < 0) \
		YY_FATAL_ERROR( "input in flex scanner failed" )
#endif

/* buffer for arbitrary length strings (longer than BUFSIZ) */
static char	*Sbuf,*Sptr,*Send;
static void beginstr(void) {
	if (Sbuf == NIL(char*)) {
		Sbuf = malloc(BUFSIZ);
		Send = Sbuf + BUFSIZ;
	}
	Sptr = Sbuf;
	*Sptr = 0;
}

static void addstr(char *src) {
	char	c;
	if (Sptr > Sbuf) Sptr--;
	do {
		do {c = *Sptr++ = *src++;} while (c && (Sptr < Send));
		if (c) {
			long	sz = Send - Sbuf;
			long	off = Sptr - Sbuf;
			sz *= 2;
			Sbuf = (char*)realloc(Sbuf,sz);
			Send = Sbuf + sz;
			Sptr = Sbuf + off;
		}
	} while (c);
}

static void endstr(void) {
	yylval.str = (char*)agstrdup(Ag_G_global,Sbuf);
}

static void endstr_html(void) {
	yylval.str = (char*)agstrdup_html(Ag_G_global,Sbuf);
}

/* chkNum:
 * The regexp for NUMBER allows a terminating letter.
 * This way we can catch a number immediately followed by a name
 * and report this to the user.
 */
static int chkNum(void) {
  unsigned char	c = (unsigned char)yytext[yyleng-1];   /* last character */
  if (!isdigit(c) && (c != '.')) {  /* c is letter */
	char	buf[BUFSIZ];
	sprintf(buf,"badly formed number '%s' in line %d\n",yytext,line_num);
    strcat (buf, "Splits into two name tokens");
	agerror(AGERROR_SYNTAX,buf);
    return 1;
  }
  else return 0;
}

/* The LETTER class below consists of ascii letters, underscore, all non-ascii
 * characters. This allows identifiers to have characters from any
 * character set independent of locale. The downside is that, for certain
 * character sets, non-letter and, in fact, undefined characters will be
 * accepted. This is not likely and, from dot's stand, shouldn't do any
 * harm. (Presumably undefined characters will be ignored in display.) And,
 * it allows a greater wealth of names. */
%}
GRAPH_EOF_TOKEN				[@]	
LETTER [A-Za-z_\200-\377]
DIGIT	[0-9]
NAME	{LETTER}({LETTER}|{DIGIT})*
NUMBER	[-]?(({DIGIT}+(\.{DIGIT}*)?)|(\.{DIGIT}+)){LETTER}?
ID		({NAME}|{NUMBER})
%x comment
%x qstring
%x hstring
%%
{GRAPH_EOF_TOKEN}	return(EOF);
<INITIAL,comment,qstring>\n	line_num++;
"/*"			BEGIN(comment);
<comment>[^*\n]*	/* eat anything not a '*' */
<comment>"*"+[^*/\n]*	/* eat up '*'s not followed by '/'s */
<comment>"*"+"/"	BEGIN(INITIAL);
"//".*			/* ignore C++-style comments */
"#".*			/* ignore shell-like comments */
[\000-\040\177]		/* ignore whitespace */
"node"			return(T_node);		/* see tokens in agcanonstr */
"edge"			return(T_edge);
"graph"			return(T_graph);
"digraph"		return(T_digraph);
"strict"		return(T_strict);
"subgraph"		return(T_subgraph);
"->"|"--"		return(T_edgeop);
{NAME}			{ yylval.str = (char*)agstrdup(Ag_G_global,yytext); return(T_atom); }
{NUMBER}		{ if (chkNum()) yyless(yyleng-1); yylval.str = (char*)agstrdup(Ag_G_global,yytext); return(T_atom); }
["]			BEGIN(qstring); beginstr();
<qstring>["]		BEGIN(INITIAL); endstr(); return (T_qatom);
<qstring>[\\]["]	addstr ("\"");
<qstring>[\\][\n]	line_num++; /* ignore escaped newlines */
<qstring>([^"\\]*|[\\].)	addstr(yytext);
[<]			BEGIN(hstring); html_nest = 1; beginstr();
<hstring>[>]		html_nest--; if (html_nest) addstr(yytext); else {BEGIN(INITIAL); endstr_html(); return (T_qatom);}
<hstring>[<]		html_nest++; addstr(yytext);
<hstring>[\n]		addstr(yytext); line_num++; /* add newlines */
<hstring>([^><]*)	addstr(yytext);
.			return (yytext[0]);
%%
void yyerror(char *str)
{
	char	buf[BUFSIZ];
	if (InputFile)
		sprintf(buf,"%s:%d: %s in line %d near '%s'",InputFile, line_num,
			str,line_num,yytext);
	else
		sprintf(buf," %s in line %d near '%s'", str,line_num,yytext);
	agerror(AGERROR_SYNTAX,buf);
}
/* must be here to see flex's macro defns */
void aglexeof() { unput(GRAPH_EOF_TOKEN); }

#ifndef YY_CALL_ONLY_ARG
# define YY_CALL_ONLY_ARG void
#endif

int yywrap(YY_CALL_ONLY_ARG)
{
	return 1;
}
