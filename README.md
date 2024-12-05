███╗   ███╗ ██████╗ ███████╗███████╗
████╗ ████║██╔═══██╗██╔════╝██╔════╝
██╔████╔██║██║   ██║███████╗███████╗
██║╚██╔╝██║██║   ██║╚════██║╚════██║
██║ ╚═╝ ██║╚██████╔╝███████║███████║
╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚══════╝

This challenge involves a C program that contains a Buffer Overflow (BOF) Vulnerability. The task is to exploit this vulnerability to gain shell access using the following methods:

Canary Leak: Exploiting the canary mechanism to bypass stack protections.
Return-Oriented Programming (ROP): Using ROP techniques to chain gadgets and execute a shell via libc.