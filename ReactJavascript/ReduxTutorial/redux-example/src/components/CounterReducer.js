import {INCREMENT, DECREMENT, RESET} from './CounterActions'


const initialState = {
    count: 0
};

 function incrementCounter (state) {
  return  {
      count: state.count + 1
    };
};

 function decrementCounter (state) {
  return {
      count: state.count - 1
  };
};

 function resetCounter (state) {
  return {
      count: 0
  };
};

export default function reducer (state=initialState, action) {
    console.log ('reducer', state, action);
    switch(action.type) {
      case INCREMENT:
        return incrementCounter(state);
      case DECREMENT:
        return decrementCounter(state);
      case RESET:
        console.log ("Cuenta", state.count)
        return resetCounter(state);
      default:
        return state;
    }
  }