#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <curses.h> // Include ncurses for terminal graphics
#include "sl.h"

int ACCIDENT = 0;
int LOGO = 0;
int FLY = 0;
int C51 = 0;

int my_mvaddstr(int y, int x, char *str) {
    for (; x < 0; ++x, ++str)
        if (*str == '\0') return ERR;
    for (; *str != '\0'; ++str, ++x)
        if (mvaddch(y, x, *str) == ERR) return ERR;
    return OK;
}

void option(char *str) {
    while (*str != '\0') {
        switch (*str++) {
            case 'a': ACCIDENT = 1; break;
            case 'F': FLY = 1; break;
            case 'l': LOGO = 1; break;
            case 'c': C51 = 1; break;
            default: break;
        }
    }
}

int main(int argc, char *argv[]) {
    int x, i;
    for (i = 1; i < argc; ++i) {
        if (*argv[i] == '-') {
            option(argv[i] + 1);
        }
    }
    
    initscr();
    signal(SIGINT, SIG_IGN);
    noecho();
    curs_set(0);
    nodelay(stdscr, TRUE);
    leaveok(stdscr, TRUE);
    scrollok(stdscr, FALSE);
    
    for (x = COLS - 1;; --x) {
        if (LOGO == 1) {
            if (add_sl(x) == ERR) break;
            else if (C51 == 1) {
                if (add_C51(x) == ERR) break;
                else {
                    if (add_D51(x) == ERR) break;
                    getch();
                    refresh();
                    usleep(40000);
                    mvcur(0, COLS - 1, LINES - 1, 0);
                    endwin();
                    return 0;
                }
            }
        }
    }
}

int add_sl(int x) {
    static char *sl[LOGOPATTERNS][LOGOHEIGHT + 1] = {
        {LOGO1, LOGO2, LOGO3, LOGO4, LWHL11, LWHL12, " "},
        {LOGO1, LOGO2, LOGO3, LOGO4, LWHL21, LWHL22, " "},
        {LOGO1, LOGO2, LOGO3, LOGO4, LWHL31, LWHL32, " "},
        {LOGO1, LOGO2, LOGO3, LOGO4, LWHL41, LWHL42, " "},
        {LOGO1, LOGO2, LOGO3, LOGO4, " ", " ", " "},
        {LOGO1, LOGO2, LOGO3, LOGO4, " ", " ", " "}
    };
    
    int i, y;
    if (x < -LOGOLENGTH) return ERR;
    y = LINES / 2 - 3;
    
    if (FLY == 1) {
        y = (x / 6) + LINES - (COLS / 6) - LOGOHEIGHT;
        for (i = 0; i <= LOGOHEIGHT; ++i) {
            my_mvaddstr(y + i, x, sl[(LOGOLENGTH + x) / 3 % LOGOPATTERNS][i]);
        }
    }
    
    if (ACCIDENT == 1) {
        add_man(y + 1, x + 14);
        add_smoke(y - 1, x + LOGOFUNNEL);
    }
    return OK;
}

int add_D51(int x) {
    static char *d51[D51PATTERNS][D51HEIGHT + 1] = {
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7},
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7},
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7},
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7},
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7},
        {D51STR1, D51STR2, D51STR3, D51STR4, D51STR5, D51STR6, D51STR7}
    };
    
    int y, i;
    if (x < -D51LENGTH) return ERR;
    y = LINES / 2 - 5;
    
    if (FLY == 1) {
        y = (x / 7) + LINES - (COLS / 7) - D51HEIGHT;
        for (i = 0; i <= D51HEIGHT; ++i) {
            my_mvaddstr(y + i, x, d51[(D51LENGTH + x) % D51PATTERNS][i]);
        }
    }
    
    if (ACCIDENT == 1) {
        add_man(y + 2, x + 43);
        add_smoke(y - 1, x + D51FUNNEL);
    }
    return OK;
}

int add_C51(int x) {
    // Define C51 design strings and implement similar to add_D51
    return OK; // Placeholder
}

void add_man(int y, int x) {
    static char *man[2][2] = {{"", "(O)"}, {"Help!", "\\O/"}};
    int i;
    for (i = 0; i < 2; ++i) {
        my_mvaddstr(y + i, x, man[(LOGOLENGTH + x) / 12 % 2][i]);
    }
}

void add_smoke(int y, int x) {
    static char *smoke_patterns[2][16] = {
        {"( )", "( )", "( )", "( )", "( )", "( )", "( )", "( )", "()", "()", "O", "O", "O", "O", "O", " "},
        {"(@@@)", "(@@@@)", "(@@@@)", "(@@@)", "(@@)", "(@@)", "(@)", "(@)", "@@", "@@", "@", "@", "@", "@", "@", " "}
    };
    
    static int sum = 0;
    if (x % 4 == 0) {
        for (int i = 0; i < sum; ++i) {
            my_mvaddstr(S[i].y, S[i].x, " "); // Erase previous smoke
            S[i].y -= 1; // Move smoke up
            my_mvaddstr(S[i].y, S[i].x, smoke_patterns[S[i].kind][S[i].ptrn]);
            S[i].ptrn += (S[i].ptrn < 15) ? 1 : 0; // Cycle through smoke patterns
        }
        // Add new smoke
        S[sum].y = y;
        S[sum].x = x;
        S[sum].ptrn = 0;
        S[sum].kind = sum % 2;
        sum++;
    }
}
