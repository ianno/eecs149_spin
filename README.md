eecs149_spin
============
SPIN model inspired by the Cruise control state machine used in UC Berkeley 
EECS 149/249 (Fall 2014) midterm 1.
The model sets a simple state machine, a non-deterministic environment and
a set of 4 LTL properties are verified.

The LTL properties are:

1.  `(x == ENABLE) -> <> (state == OFF) `
2.  `[]((x == DISABLE) -> <>(state == OFF)) `
3.  `[](count == 0) -> <>(state == OFF)`
4.  `[]( (state == HOLD) -> ((x != DISABLE) && (x != RESUME) )) -> <>(state == STANDBY) `

To compile and verify the model you can use 'ispin' (SPIN graphical environment),
or, using the command line, with:

- `spin -a cruise.pml`
- `gcc -o pan pan.c`
- `./pan -N p1 (for property p1)`
- `./pan -N p2 (for property p2)`
- ...

Author: Antonio Iannopollo

Email: antonio@berkeley.edu

