import React from "react";
import {Component} from "react";
import {connect} from 'react-redux';
import {increment, decrement, reset} from '../Actions'

function mapStateToProps (state) {
    return {
        count: state.count
    };
};

export function incrementCounter (state) {
    return  {
        count: state.count + 1
      };
};

export function decrementCounter (state) {
    return {
        count: state.count - 1
    };
};

export function resetCounter (state) {
    return {
        count: 0
    };
};

class Counter extends Component {
    //state = {count: 0}


    increment = () => {
        /*this.setState ({
            count: this.state.count + 1
        })*/
        this.props.dispatch(increment());
    };

    decrement = () => {
        /*this.setState ({
            count:this.state.count - 1
        })*/
        this.props.dispatch(decrement());
    };

    reset = () => {
        this.props.dispatch(reset())
    }

    render () {
        return (
            <div>
                <h2>
                    Counter
                </h2>
                <div>
                    <button onClick={this.decrement}>-</button>
                    <span>{
                        this.props.count
                    }</span>
                    <button onClick={this.increment}>+</button>
                    <button onClick={this.reset}>Reset</button>
                </div>
            </div>
        )
    }
}
//export default Counter;
export default connect (mapStateToProps) (Counter);
