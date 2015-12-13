require 'pg'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "brussels_sprouts_recipes")
    yield(connection)
  ensure
    connection.close
  end
end

TITLES = ["Roasted Brussels Sprouts",
  "Fresh Brussels Sprouts Soup",
  "Brussels Sprouts with Toasted Breadcrumbs, Parmesan, and Lemon",
  "Cheesy Maple Roasted Brussels Sprouts and Broccoli with Dried Cherries",
  "Hot Cheesy Roasted Brussels Sprout Dip",
  "Pomegranate Roasted Brussels Sprouts with Red Grapes and Farro",
  "Roasted Brussels Sprout and Red Potato Salad",
  "Smoky Buttered Brussels Sprouts",
  "Sweet and Spicy Roasted Brussels Sprouts",
  "Smoky Buttered Brussels Sprouts",
  "Brussels Sprouts and Egg Salad with Hazelnuts"]

COMMENTS = [
   {0 => "Definitely edible."},
   {1 => "Needs a ton of salt"},
   {2 => "DElicious time saver."},
   {3 => "Quick and easy"},
   {4 => "Ordered take out instead!"},
   {5 => "I've had better."},
   {6 => "Make me puke!"},
   {7 => "My dogs loved this."},
   {8 => "Best brussels ever!"},
   {9 => "Too spicy!"},
   {10 => "Terrible last meal."},
   {8 => "Great leftovers!"},
   {2 => "I'll definitely make this again!"},
   {4 => "Try it with some bacon!"}
  ]

system 'psql brussels_sprouts_recipes < schema.sql'

# TITLES.each_with_index do |item, index|
#   sql_query = "INSERT INTO recipes (recipe_id, recipe) VALUES ($1,$2)"
#   data = [index, item]
#   db_connection { |conn| conn.exec_params(sql_query, data) }
# end

db_connection do |conn|
  TITLES.each_with_index do |item, index|
    conn.exec_params("INSERT INTO recipes (recipe_id, recipe) VALUES ($1,$2)", [ index, item])
  end
  COMMENTS.each do |hash|
    hash.each do |key, value|
      conn.exec_params("INSERT INTO comments (comment_id, comment) VALUES ($1, $2)", [key, value])
    end
  end
end



sql_query = 'SELECT count(*) FROM recipes;'
result = ""
db_connection do |conn|
  result = conn.exec(sql_query)
end

puts result.first["count"]


# SELECT count(*) FROM comments;
#
# SELECT count(*) FROM comments where comment_id = 4;
#
SELECT recipes.recipe, comments.comment FROM recipes, comments
WHERE recipes.recipe_id = comments.comment_id;
#
# INSERT INTO recipes (recipe, recipe_id) VALUES ('Brussels Sprouts with Goat Cheese', 11);
# INSERT INTO comments (comment, comment_id) VALUES ('So good, I even licked the plate!')
# INSERT INTO comments (comment, comment_id) VALUES ('They must\'ve put something in here.');
