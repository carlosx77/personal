import React from 'react';
import {Component} from "react"
import './App.css';


  
function  logColor (title, color) {
  alert(`New Color: ${title} | ${color}`);
}


function App() {
  return (
    <div className="App">
      <header className="App-header"> 
        <AddColorForm onNewColor={logColor()}/>
      </header>
    </div>
  );
}

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
      //alert (`New Color: ${this.refs._title.value} ${this.refs._color.value}`)
      _title.value = '';
      _color.value = '#000000';
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

export default App;
