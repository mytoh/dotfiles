/* See LICENSE file for copyright and license details. */

/* appearance */
#define NUMCOLORS     4       // need at least 3
static const char colors[NUMCOLORS][ColLast][8] = {
    // border   foreground  background
    { "#151515", "#6d6d6d", "#222222" },  // 0 = normal
    { "#607080", "#607080", "#222222" },  // 1 = selected
    { "#607080", "#607080", "#6d6d6d" },  // 2 = urgent/warnig
    { "#ff0000", "#ffffff", "#ff0000" },  // 3 = error
    // add more here
};

static const char font[]            = "-*-terminusmodmod-medium-r-normal--12-*-*-*-*-*-*-*";
static const unsigned int borderpx  = 1;        /* border pixel of windows */
static const unsigned int gappx     = 2;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const Bool showbar           = True;     /* False means no bar */
static const Bool topbar            = True;     /* False means bottom bar */
static const double shade           = 0.8;      /* Opacity of inactive windows */
static const double baropacity      = 0.95;     /* Opacity for status bar */

/* tagging */
static const char *tags[] = {"tyhjä", "pääte", "net", "media"};

static const Rule rules[] = {
  /* class        instance    title       tags mask     isfloating   monitor     opacity */
  { "Gimp",       NULL,       NULL,       0,            True,         -1,       -1   },
  { "Firefox",    NULL,       NULL,       1 << 2,       False,        -1,       -1   },
  { NULL,NULL,"Firefox Preferences",      1 << 1,       True,         -1,       -1  },
  { "Dialog",     NULL,       NULL,       0,            True,         -1,       0.90 },
  { "ROX-Filer",  NULL,       NULL,       0,            True,         -1,       0.90 },
  { "feh",        NULL,       NULL,       0,            True,         -1,       -1   },
  { "Switch2",    NULL,       NULL,       0,            True,         -1,       -1   },
  { "Thunar",     NULL,       NULL,       0,            True,         -1,       -1   },
  { "URxvt",      NULL,       NULL,       0,            False,        -1,       0.92 },
  { "Comix",      NULL,       NULL,       0,            False,        -1,       0.92 },
  { "GImageView", NULL,       NULL,       0,            False,        -1,       0.92 },
};

/* layout(s) */
static const float mfact      = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster      = 1;    /* number of clients in master area */
static const Bool resizehints = False; /* True means respect size hints in tiled resizals */

/* bstack layout */
#include "bstack.c"
#include "bstackhoriz.c"

static const Layout layouts[] = {
  /* symbol     arrange function */
  { "ú",      tile },    /* first entry is default */
  { "ÿ",      NULL },    /* no layout function means floating behavior */
  { "[M]",      monocle },
  { "ü",      bstack },
  { "û",      bstackhoriz },
 { .symbol = NULL, .arrange = NULL }, /* for nextlayout function */
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
  { MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
  { MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
  { MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "dmenu_run", "-b", "-fn", font, "-nb", colors[0][ColBG], "-nf", colors[0][ColFG], "-sb", colors[1][ColBG], "-sf", colors[1][ColFG], NULL };
static const char *termcmd[]  = { "urxvtcd", NULL };
static const char *dwmquitcmd[] = { "killall", "dwm", NULL };

static Key keys[] = {
  /* modifier                     key        function        argument */
  { MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
  { MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
  { MODKEY,                       XK_b,      togglebar,      {0} },
  { MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
  { MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
  { MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
  { MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
  { MODKEY,                       XK_Return, zoom,           {0} },
  { MODKEY,                       XK_Tab,      focusstack,     {.i = +1 } },
  //{ MODKEY,                       XK_Tab,    view,           {0} },
  { MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
  { MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
  { MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
  { MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
 /* { MODKEY,                       XK_space,  setlayout,      {0} }, */
  { MODKEY,                       XK_space,  nextlayout,      {0} }, 
  { MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
  { MODKEY,                       XK_0,      view,           {.ui = ~0 } },
  { MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
  { MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
  { MODKEY,                       XK_period, focusmon,       {.i = +1 } },
  { MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
  { MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
  TAGKEYS(                        XK_1,                      0)
  TAGKEYS(                        XK_2,                      1)
  TAGKEYS(                        XK_3,                      2)
  TAGKEYS(                        XK_4,                      3)
  TAGKEYS(                        XK_5,                      4)
  TAGKEYS(                        XK_6,                      5)
  TAGKEYS(                        XK_7,                      6)
  TAGKEYS(                        XK_8,                      7)
  TAGKEYS(                        XK_9,                      8)
  { MODKEY|ShiftMask,             XK_q,      spawn,          {.v = dwmquitcmd } },
  { MODKEY|ShiftMask,             XK_r,      quit,           {0} },
};

/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
  /* click                event mask      button          function        argument */
  { ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
  { ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
  { ClkWinTitle,          0,              Button2,        zoom,           {0} },
  { ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
  { ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
  { ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
  { ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
  { ClkTagBar,            0,              Button1,        view,           {0} },
  { ClkTagBar,            0,              Button3,        toggleview,     {0} },
  { ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
  { ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

