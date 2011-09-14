TicTacToe
==========

So I started off trying to write a simple Sudoku game but ended up going the 
simpler route and doing a simple version of tictactoe.

The coding is a little off key from my norm but it was a good learning
experience and I tried to touch on a few things I've not played with before.

Patches welcome, it'd be nice to work on something else - Vala is a joy!

I've not added a waf/makefile script etc as I've seen a lot of ways to do it
and, as it was fairly simple, I figured a better understanding could be gained
from just leaving the code as is with instructions.

To build:

<code>
valac --pkg gtk+-3.0 -o TicTacToe TicTacToeBox.vala TicTacToeBoard.vala TicTacToeWindow.vala
</code>

If there is an agreed build method or standard, point me in the right direction
or patch it in for me.
