import {combineReducers} from 'redux';
import userReducer from './components/UserReducer';
import reducer from './components/CounterReducer';

// this variables will be accessed as props.users.
export default combineReducers ({
    count: reducer,
    users: userReducer
});

/*
Using combineReducers dont let one reducer to see the props of another reducer.
To share props between reducers you need to user ReduceReducers!!!

*/