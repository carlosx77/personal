import React, {Component} from "react";
import FirstChild from "./FirstChild";

class ParentComponent extends Component {
    render() {
        return ( 
            <>
                <h1>I'm the parent Component</h1>
                <FirstChild/> 
            </>
        );
    }
}

export default ParentComponent;