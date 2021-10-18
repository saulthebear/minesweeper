# 💣 Ruby Minesweeper 💣

A terminal-based minesweeper clone written in Ruby.

## How to Play
To start the game run
```bash
ruby lib/game.rb
```

To learn more about the game of Minesweeper, check out the [Wikipedia page](https://en.wikipedia.org/wiki/Minesweeper_(video_game))


### Commands

Positions are entered as two comma seperated integers (eg. row 0 column 7 is entered as `0,7`)

`r <position>` - 🔎 Reveal a tile

`f <position>` - ⛳️ Flag a tile where you suspect a bomb is

`s` - 💾 Save the game and exit

`l` - 🗂 Load a saved game

#### Examples
```ruby
~ ruby lib/game.rb

============= Welcome to Minesweeper! =============

================== INSTRUCTIONS ===================
Commands are one letter followed by a position, eg.
    r 0,4 => reveal row 0 column 4
    f 5,2 => flag row 5 column 2
===================================================

   0  1  2  3  4  5  6  7  8
0  *  *  *  *  *  *  *  *  *
1  *  *  *  *  *  *  *  *  *
2  *  *  *  *  *  *  *  *  *
3  *  *  *  *  *  *  *  *  *
4  *  *  *  *  *  *  *  *  *
5  *  *  *  *  *  *  *  *  *
6  *  *  *  *  *  *  *  *  *
7  *  *  *  *  *  *  *  *  *
8  *  *  *  *  *  *  *  *  *
Enter a command:
> r 0,4
# => reveal position 0,4

   0  1  2  3  4  5  6  7  8
0  *  *  1  _  _  _  1  *  *
1  *  *  1  _  _  _  1  *  *
2  *  *  2  1  1  _  1  2  2
3  *  *  *  *  1  _  _  _  _
4  *  *  *  *  1  _  _  1  1
5  *  *  *  *  1  _  _  1  *
6  *  *  *  *  2  _  _  1  1
7  *  *  *  *  3  1  _  _  _
8  *  *  *  *  *  1  _  _  _
Enter a command:
> f 3,3
# => flag position 3,3

   0  1  2  3  4  5  6  7  8
0  *  *  1  _  _  _  1  *  *
1  *  *  1  _  _  _  1  *  *
2  *  *  2  1  1  _  1  2  2
3  *  *  *  F  1  _  _  _  _
4  *  *  *  *  1  _  _  1  1
5  *  *  *  *  1  _  _  1  *
6  *  *  *  *  2  _  _  1  1
7  *  *  *  *  3  1  _  _  _
8  *  *  *  *  *  1  _  _  _
Enter a command:
> s
Saving the game as savegames/game-003.yaml.

~ ruby lib/game.rb

   0  1  2  3  4  5  6  7  8
0  *  *  *  *  *  *  *  *  *
1  *  *  *  *  *  *  *  *  *
2  *  *  *  *  *  *  *  *  *
3  *  *  *  *  *  *  *  *  *
4  *  *  *  *  *  *  *  *  *
5  *  *  *  *  *  *  *  *  *
6  *  *  *  *  *  *  *  *  *
7  *  *  *  *  *  *  *  *  *
8  *  *  *  *  *  *  *  *  *
Enter a command:
> l
I found these savegames:
1: game-001.yaml
2: game-002.yaml
3: game-003.yaml
Which one would you like to open? (enter the number on the left)
> 3

   0  1  2  3  4  5  6  7  8
0  *  *  1  _  _  _  1  *  *
1  *  *  1  _  _  _  1  *  *
2  *  *  2  1  1  _  1  2  2
3  *  *  *  F  1  _  _  _  _
4  *  *  *  *  1  _  _  1  1
5  *  *  *  *  1  _  _  1  *
6  *  *  *  *  2  _  _  1  1
7  *  *  *  *  3  1  _  _  _
8  *  *  *  *  *  1  _  _  _
Enter a command:
>
```


## About this Project
Written by Stefan Vosloo following the [*Minesweeper Project*](https://open.appacademy.io/learn/full-stack-online/ruby/minesweeper) instructions from AppAcademy Open
