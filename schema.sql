DROP TABLE IF EXISTS recipes;
DROP TABLE IF EXISTS comments;

CREATE TABLE recipes (id SERIAL PRIMARY KEY, recipe VARCHAR(225));

CREATE TABLE comments (id SERIAL PRIMARY KEY, recipe_id, comment TEXT);
-- Add Foreign key

-- SELECT recipes.recipe, comments.comment FROM recipes, comments
-- brussels_sprouts_recipes WHERE recipes.recipe_id = comments.recipe_id;
