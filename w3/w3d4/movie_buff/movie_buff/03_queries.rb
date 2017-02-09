def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  Movie.select(:title, :id).joins(:actors).where("actors.name IN (?)", those_actors).group(:id).having("count(*) = (?)", those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.group("yr - MOD(yr, 10)").order("AVG(score) DESC").limit(1).pluck("(yr - MOD(yr, 10))").first
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  movie_ids = Movie.joins(:actors).where("actors.name = (?)", name).pluck(:id)
  Movie.joins(:actors).where("movies.id IN (?) AND actors.name <> (?)", movie_ids, name).pluck("actors.name").uniq
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins("LEFT OUTER JOIN castings ON castings.actor_id = actors.id").where("castings.id IS NULL").count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"

  query = "%#{whazzername.chars.join("%").downcase}%"
  Movie.joins(:actors).where("LOWER(actors.name) LIKE (?)", query)

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.
  Movie.select("actors.id, actors.name, (MAX(yr) - MIN(yr)) AS career").
    joins(:actors).group("actors.id").order("career DESC, actors.name ASC").limit(3)
end
