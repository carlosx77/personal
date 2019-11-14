import Recipe from './Recipe'
function Menu (props) {
    return (
        <article>
            <header>
                <h1>{props.title}</h1>
            </header>
            <div className="recipes">
                { props.recipes.map((recipe, i) => <Recipe key={i} {...recipe} />) }
            </div>
        </article>
    );
};

export default Menu;