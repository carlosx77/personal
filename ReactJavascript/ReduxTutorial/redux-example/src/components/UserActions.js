
export const FETCH_USERS_BEGIN = 'FETCH_USERS_BEGIN';
export const FETCH_USERS_SUCCESS = 'FETCH_USERS_SUCCESS';
export const FETCH_USERS_FAILURE = 'FETCH_USERS_FAILURE';

export const fetchUsersBegin = () => ({
    type: FETCH_USERS_BEGIN
});

export const fetchUsersSuccess = (users) => { 
         console.log ("usuarios que llegan al user success: ", users);
    return {
        type: FETCH_USERS_SUCCESS,
        payload: {users}
    }
};

export const fetchUsersFailure = (error) => ({
    type: FETCH_USERS_FAILURE,
    payload: {error}
});

export function fetchUsers (count) {
    //console.log ("Fetching");
    return dispatch => {
        dispatch (fetchUsersBegin());
        //console.log("PROPERTIES", `https://api.randomuser.me/?nat=US&results=`, {count});
        //console.log("LIGA", `https://api.randomuser.me/?nat=US&results=`, {count});
        return fetch (`https://api.randomuser.me/?nat=US&results=3`)
        .then(res => res.json())
        .then(json => {
            //console.log ("returning",  json['results'] );
            dispatch (fetchUsersSuccess( json['results'] ));
            //json.results.map ( user=> console.log(user) );      
            return json['results'] ;
        })
        .catch (error => dispatch(fetchUsersFailure(error) ) );
    };
}