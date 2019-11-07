import {combineReducers} from 'redux';
import userReducer from './components/UserReducer';
import reducerCounter from './App.js';

export default combineReducers ({
    users: userReducer,
    count: reducerCounter
});