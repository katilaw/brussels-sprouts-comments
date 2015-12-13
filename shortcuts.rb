dg_connection do |conn|
  conn.exec_params("SELECT recipe, count (*) FROM comments JOIN recipes ON recipe_id = recipes.id GROUP BY recipe_id ORDER BY recipe_id ")
