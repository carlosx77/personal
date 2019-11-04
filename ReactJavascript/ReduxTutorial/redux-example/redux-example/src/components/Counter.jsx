import React from "react";
import {Component} from "react";
import {connect} from 'react-redux';
import {INCREMENT, DECREMENT, RESET} from '../Actions'

function mapStateToProps (state) {
    return {
        count: state.count
    }
}

class Counter extends Component {
    //state = {count: 0}


    increment = () => {
        /*this.setState ({
            count: this.state.count + 1
        })*/
        this.props.dispatch({type: INCREMENT});
    };

    decrement = () => {
        /*this.setState ({
            count:this.state.count - 1
        })*/
        this.props.dispatch({type: DECREMENT});
    };

    reset = () => {
        this.props.dispatch({type: RESET})
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
                        //this.state.count
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