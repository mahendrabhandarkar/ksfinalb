package com.ks.ksfinalb.sttimpl;

import org.springframework.statemachine.listener.StateMachineListenerAdapter;
import org.springframework.statemachine.state.State;

import java.util.logging.Logger;

/*
Listener used to log the state change
Transitions: The movement from one state to another, often associated with actions.
Guards: Conditions that must be met for a transition to occur.
Actions: Code executed as a result of a transition.
*/
public class StateMachineListener extends StateMachineListenerAdapter {

    private static final Logger LOGGER = Logger.getLogger(StateMachineListener.class.getName());

    @Override
    public void stateChanged(State from, State to) {
        LOGGER.info(() -> String.format("Transitioned from %s to %s%n", from == null ? "none" : from.getId(), to.getId()));
    }
}
