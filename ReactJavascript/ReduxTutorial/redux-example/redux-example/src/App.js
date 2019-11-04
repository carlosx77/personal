import React from 'react';
import './App.css';
import Counter from "./components/Counter";
import {createStore} from 'redux';
import {Provider} from 'react-redux';
import {INCREMENT, DECREMENT, RESET} from './Actions'
import {increment, decrement, reset} from './Actions'

const initialState = {
  count: 0
}

const store = createStore(reducer);

//Actions:
store.dispatch( increment() );
store.dispatch( decrement() );
store.dispatch( reset() );


function reducer (state=initialState, action) {
  console.log ('reducer', state, action);
  switch(action.type) {
    case INCREMENT:
      return {
        count: state.count + 1
      };
    case DECREMENT:
      return {
        count: state.count - 1
      };
    case RESET:
      return {
        count: state.count = 0
      };
    default:
      return state;
  }
}

function App() {
  return (
    <Provider store={store}>
    <div className="App">
      <header className="App-header">
        <Counter/>
      </header>
    </div>
    </Provider>
  );
}

export default App;
