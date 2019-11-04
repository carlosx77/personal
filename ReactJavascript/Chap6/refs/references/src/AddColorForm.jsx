import React from "react"
import {Component} from "react"

class AddColorForm extends Component {

    constructor (props) {
        super (props)
        this.submit = this.submit.bind(this)
    }
	
    submit(e) {
        e.preventDefault();

        const {
            _title, _color
        } = this.refs
        
        //alert(`New Color: ${_title.value} ${_color.value}`) //OR
        alert (`New Color: ${this.refs._title.value} ${this.refs._color.value}`)
        _title.value = '';
        _color.value = '#0000000';
        _title.focus();
    }

    render () {
        return (
            <form onSubmit={this.submit}>
                <input ref="_title" type="text" placeholder="color title..." required/>
                <input ref="_color" type="color" required/>
                <button>ADD</button>
            </form>
        )
    }
}


const logColor = (title, color) =>
console.log(`New Color: ${title} | ${color}`)

export default AddColorForm;