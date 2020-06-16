/*
*   Christopher Rudel
*   Professor Xu
*   CS 392
*   cs392_signal.h
*   I pledge my honor that I have abided by the Stevens Honor System
*
*/

#ifndef CS392_SIGNAL_H
#define CS392_SIGNAL_H

#include <stdio.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <errno.h>
void hdl(int,siginfo_t*,void*);
void handleSignal();

#endif