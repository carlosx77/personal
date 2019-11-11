import React from 'react';
import './App.css';
import Counter from "./components/Counter";
import {Provider} from 'react-redux';
import {increment, decrement, reset} from './components/CounterActions'
import {fetchUsersBegin, fetchUsersFailure, fetchUsersSuccess} from './components/UserActions'
import {createStore, applyMiddleware} from 'redux';
import thunk from 'redux-thunk';
import rootReducer from './RootReducer';
import UsersList from './components/UsersList'

//const store = createStore(rootReducer);

const store = createStore (rootReducer, applyMiddleware(thunk));

//Actions:
store.dispatch( increment() );
store.dispatch( decrement() );
store.dispatch( reset() );
store.dispatch( fetchUsersBegin() );
store.dispatch( fetchUsersSuccess() );
store.dispatch( fetchUsersFailure() );

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
//</header> <UsersList></UsersList>    <Counter/>

/*
REACT dont let us by default to make use of go forward and back arrows on browsers, neither use a direct link
to make use of this we use REACT ROUTE: npm i react-router-dom --save
Check REACT ROUTER DOC: https://github.com/ReactTraining/react-router
*/
export default App;  
