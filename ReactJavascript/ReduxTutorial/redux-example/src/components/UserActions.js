
export const FETCH_USERS_BEGIN = 'FETCH_USERS_BEGIN';
export const FETCH_USERS_SUCCESS = 'FETCH_USERS_SUCCESS';
export const FETCH_USERS_FAILURE = 'FETCH_USERS_FAILURE';

export const fetchUsersBegin = () => ({
    type: FETCH_USERS_BEGIN
});

export const fetchUsersSuccess = (users) => { 
         //console.log ("usuarios que llegan al user success: ", users);
    return {
        type: FETCH_USERS_SUCCESS,
        payload: users
    }
};

export const fetchUsersFailure = (error) => ({
    type: FETCH_USERS_FAILURE,
    payload: {error}
});

export function fetchUsers () {
    console.log ("Fetching");
    return dispatch => {
        dispatch (fetchUsersBegin());
        return fetch ("https://api.randomuser.me/?nat=US&results=2")
        .then(res => res.json())
        .then(json => {
            dispatch (fetchUsersSuccess( json ));
            //json.results.map ( user=> console.log(user) );
            console.log ("returning",  json );
            return json ;
        })
        .catch (error => dispatch(fetchUsersFailure(error) ) );
    };
}