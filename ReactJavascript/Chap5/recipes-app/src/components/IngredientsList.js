import React from "react"
function IngredientsList ({name, ingredients}) {
    return (
        <>
        <h2>{name}</h2>
        <ul className="ingredients">
            {ingredients.map((ingredient, i) => (<Ingredient key={i} ingredient={ingredient}/>))}
        </ul>
        </>
    );
}
export default IngredientsList;