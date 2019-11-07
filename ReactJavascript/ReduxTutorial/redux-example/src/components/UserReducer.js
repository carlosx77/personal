import {
    FETCH_USERS_BEGIN,
    FETCH_USERS_SUCCESS,
    FETCH_USERS_FAILURE
} from './UserActions';

const initialState = {
    users: [],
    loading: false,
    error: null
}

export default function userReducer (state=initialState, action) {
    console.log ("Accion: ", action)
    switch (action.type) {
        case FETCH_USERS_BEGIN:
            return { 
                ...state,
                loading: true,
                error: null,
                users: []
            };
        case FETCH_USERS_SUCCESS:
            if ( action.payload == null ) {
                return {
                    ...state,
                    loading: false,
                    users: []
                }
            } else {
                return {
                    ...state,
                    loading: false,
                    users: action.payload['results']
                }
            }

        case FETCH_USERS_FAILURE:
            return {
                ...state,
                loading: false,
                error: action.payload.error,
                users: []
            }
        default:
        return state;
    }
}