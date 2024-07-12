<?php
require_once "../../config.php";
require_once "../../model/Recipe.php";

$pdo = new PDO( DB_TYPE.":host=".DB_HOST.";dbname=".DB_NAME.";port=".DB_PORT.";charset=".DB_CHARSET,
DB_LOGIN,
DB_PWD);

$result = Comment::insertCommentByForm($pdo, ID_RECIPE_MOUS);
$recipe = Recipe::getRecipeById($pdo, ID_RECIPE_MOUS);
$recipeAverage = $recipe->getStarAverage();

require_once "mous.php";