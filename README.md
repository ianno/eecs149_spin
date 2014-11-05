eecs149_spin
============
SPIN model inspired by the Cruise control state machine used in UC Berkeley 
EECS 149/249 (Fall 2014) midterm 1.
The model sets a simple state machine, a non-deterministic environment and
a set of 4 LTL properties are verified.

The LTL properties are:
1. (x == ENABLE) -> <> (state == OFF) 
2. []((x == DISABLE) -> <>(state == OFF)) 
3. [](count == 0) -> <>(state == OFF)
4. []( (state == HOLD) -> ((x != DISABLE) && (x != RESUME) )) -> <>(state == STANDBY) 

Author: Antonio Iannopollo
Email: antonio@berkeley.edu

