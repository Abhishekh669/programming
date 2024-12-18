// sl.h
#ifndef SL_H
#define SL_H

#define LOGOHEIGHT 6
#define LOGOLENGTH 84
#define LOGOPATTERNS 6

// Logo designs
#define LOGO1 " ++ +------ "
#define LOGO2 " || |+-+ | "
#define LOGO3 " /---------|| | | "
#define LOGO4 " + ======== +-+ | "

// Wing and wheel designs
#define LWHL11 " _|--O========O~\\-+ "
#define LWHL12 "//// \\_/ \\_/ "
#define LWHL21 " _|--/O========O\\-+ "
#define LWHL22 "//// \\_/ \\_/ "
#define LWHL31 " _|--/~O========O-+ "
#define LWHL32 "//// \\_/ \\_/ "
#define LWHL41 " _|--/~\\------/~\\-+ "
#define LWHL42 "//// \\_O========O "

// D51 plane definitions
#define D51HEIGHT 10
#define D51LENGTH 83
#define D51PATTERNS 6
#define D51FUNNEL 7

// D51 design strings
#define D51STR1 " ==== ________ ___________ "
#define D51STR2 " _D _| |_______/ \\__I_I_____===__|_________| "
#define D51STR3 " |(_)--- | H\\________/ | | =|___ ___| "
#define D51STR4 " / | | H | | | | ||_| |_|| "
#define D51STR5 " | | | H |__--------------------| [___] | "
#define D51STR6 " | ________|___H__/__|_____/[][]~\\_______| | "
#define D51STR7 " |/ | |-----------I_____I [][] [] D |=======|__ "

// Function prototypes
void add_smoke(int y, int x);
void add_man(int y, int x);
int add_C51(int x);
int add_D51(int x);
int add_sl(int x);
void option(char *str);
int my_mvaddstr(int y, int x, char *str);

#endif // SL_H
