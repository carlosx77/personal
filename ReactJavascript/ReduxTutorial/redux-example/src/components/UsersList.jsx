import React from 'react';
import {connect} from 'react-redux';
import {fetchUsers} from "./UserActions";


function  mapStateToProps (state) {
    //let algo =  JSON.parse(JSON.stringify(state));
    //console.log ("ALGO: ", algo);
    return {
        // follow the structure: state.reducernameinRootReducer.data
        users: state.users.users,
        loading: state.users.loading,
        error: state.users.error
    }
};

class UsersList extends React.Component {

    /*state = {
        users: [],
        loading: false,
        error: null
    };*/

    

    //This method is invoked when loading the web page, so we can see a list of users when the page renders for first time
    componentDidMount () {
        this.props.dispatch (fetchUsers());
    }

    /*///////////////////////  REACT COMPONENTS LIFECYCLE  /////////////////////
        Components have a lifecycle and we can take advantage of that lifecicle to define events on each stage of that lifecycle

        //RENDER
        componentWillMount
        componentDidMount

        //STATE CHANGE
        shouldComponentUpdate
        componentWillUpdate
        componentDidUpdate
        
        //PROPS CHANGE
        componentWillReceiveProps
        shouldComponentUpdate
        componentWillUpdate
        componentDidUpdate

        componentDidCatch

        // UNMOUNTING COMPONENT
        componentWillUnmount
    */

   componentWillMount () {
       console.log ("componentWillMount");
   }
   componentWillUnmount () {
       console.log("componentWillUnmount");
   }

   componentWillUpdate(newProps, newState) {
       console.log("componentWillUpdate");
   }

   componentDidUpdate(currentProps, currentState) {
       console.log("componentDidUpdate");
   }

   shouldComponentUpdate (newProps, newState) {
       console.log ("shouldComponentUpdate");
       // here we can decide if we want to update the component:
       /* if (newState.count < 5) {
        console.log("shouldComponentUpdate: Component should update!");
        return true;
      } else {
        ReactDOM.unmountComponentAtNode(destination);
        console.log("shouldComponentUpdate: Component should not update!");
        return false;
      } */
      return true;
   }

   componentWillReceiveProps (newProps) {
       console.log ("componentWillReceiveProps");
   }
   
   componentDidCatch () {
       console.log ("componentDidCatch");
   }


    actualizar = () => {
        this.props.dispatch(fetchUsers());
    };
    

    render () {
        const {error, loading, users, count} = this.props;
 
        if (error) {
            return <div>Error! {error.message}</div>;
        }
        if (loading) {
            return <div>Loading...</div>;
        }

        return ( 
            <>
            <h2>
                Users List
            </h2>
            <ul>
                {users.map(
                    (user, i) => 
                    <li key={user.id.value}>{user.name.first}</li>

                )} 
            </ul>
            {console.log("props", this.props)}
            <button onClick={this.actualizar}>Update list</button>
            </>
        );
    }
}

//export default Counter;
export default connect (mapStateToProps) (UsersList);