import React from 'react';
import {connect} from 'react-redux';
import {fetchUsers} from "./UserActions";

const mapStateToProps = (state) => ({
    users: state.users.users,
    loading: state.users.loading,
    error: state.users.error
});

class UsersList extends React.Component {

    /*componentDidMount () {
        this.props.dispatch (fetchUsers());
    }*/

    actualizar = () => {
        this.props.dispatch(fetchUsers());
    };
    

    render () {
        console.log ("Props: ", this.props);
        const {error, loading, users} = this.props;
        console.log ("Error: ", error);
        console.log ("loading: ", loading);
        console.log ("Users:  ", users);
        if (error) {
            return <div>Error! {error.message}</div>;
        }
        if (loading) {
            return <div>Loading...</div>;
        }
        return ( 
            <>
            <ul>
                {users.map(
                    (user, i) => 
                    <li key={user.id.value}>{user.name.first}</li>

                )}
            </ul>
            <button onClick={this.actualizar}>Actualizar lista</button>
            </>
        );
    }
}

//export default Counter;
export default connect (mapStateToProps) (UsersList);