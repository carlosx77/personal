import React from 'react';
import './App.css';
import Counter from "./components/Counter";
import {incrementCounter, decrementCounter, resetCounter} from './components/Counter'
import {Provider} from 'react-redux';
import {INCREMENT, DECREMENT, RESET} from './Actions'
import {increment, decrement, reset} from './Actions'
import {createStore, applyMiddleware} from 'redux';
import thunk from 'redux-thunk';
import rootReducer from './RootReducer';
import {fetchUsersBegin, fetchUsersSuccess, fetchUsersFailure} from './components/UserActions';
import UsersList from './components/UsersList';



const initialState = {
  count: 0
}

//const store = createStore(reducer, applyMiddleware(thunk));

const store = createStore (rootReducer, applyMiddleware(thunk));

//Actions:
store.dispatch( increment() );
store.dispatch( decrement() );
store.dispatch( reset() );
store.dispatch( fetchUsersBegin () );
store.dispatch( fetchUsersSuccess () );
store.dispatch( fetchUsersFailure () );


function reducer (state=initialState, action) {
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

function App() {
  return (
    <Provider store={store}>
    <div className="App">
      <header className="App-header">
        <Counter/>
        <UsersList></UsersList>
      </header>
      
    </div>

    </Provider>
    
  );
}

export default App;
