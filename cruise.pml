/*
* SPIN model inspired by the Cruise control state machine used in UC Berkeley 
* EECS 149/249 (Fall 2014) midterm 1.
* The model sets a simple state machine, a non-deterministic environment and
* a set of 4 LTL properties are verified.
*
* Author: Antonio Iannopollo
*/

//definition of input values
mtype = {ENABLE, SET, CANCEL, BRAKE, RESUME, DISABLE};
//state definition
mtype = {OFF, STANDBY, CRUISE, HOLD};

//state machine variables
mtype state = OFF;
byte count = 0;
mtype x = SET;

//communication channel
chan input = [0] of {mtype};

/*
* Non-deterministic environment
*/
active proctype Environment() {
    do
        ::if
            :: input ! ENABLE;
            :: input ! SET;
            :: input ! CANCEL;
            :: input ! BRAKE;
            :: input ! RESUME;
            :: input ! DISABLE;
        fi;
        //or equivalently
        //select(x : DISABLE .. ENABLE);
    od;
}

/*
* Cruise control state machine
*/
active proctype Cruise() {
    do
        :: atomic { input ? x ->
            if 
                :: (state == OFF) && (x == ENABLE) -> 
                  count = 0; state = STANDBY;
                :: (state == STANDBY) && (x == DISABLE) ->
                    state = OFF;
                :: (state == STANDBY) && (x == SET) ->
                    state = CRUISE;
                :: (state == CRUISE) && (x == DISABLE) ->
                    state = OFF;
                :: (state == CRUISE) && (x == CANCEL) ->
                    state = STANDBY;
                :: (state == CRUISE) && (x == BRAKE) ->
                    state = HOLD;
                :: (state == HOLD) && (x == RESUME) ->
                    state = CRUISE;
                :: (state == HOLD) && (x == DISABLE) ->
                    state = OFF;
                :: (state == HOLD) && ((count == 2) || (x == CANCEL)) ->
                    count = 0; state = STANDBY
                :: (state == HOLD) && ! ((x == RESUME) || \
                    (x == DISABLE) || ((count == 2) || (x == CANCEL)) ) ->
                    count = count + 1;
                :: else -> skip;
            fi;
        }
    od;
          
}


/*
* LTL properties
*/

ltl p1 { (x == ENABLE) -> <> (state == OFF) }

ltl p2 { []((x == DISABLE) -> <>(state == OFF)) }

ltl p3 { [](count == 0) -> <>(state == OFF)}

ltl p4 { []( (state == HOLD) -> ((x != DISABLE) && (x != RESUME) )) -> <>(state == STANDBY) }

