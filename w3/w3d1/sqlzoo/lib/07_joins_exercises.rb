# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#
#  movie_id    :integer      not null, primary key
#  actor_id    :integer      not null, primary key
#  ord         :integer

require_relative './sqlzoo.rb'

def example_join
  execute(<<-SQL)
    SELECT
      *
    FROM
      movies
    JOIN
      castings ON movies.id = castings.movie_id
    JOIN
      actors ON castings.actor_id = actors.id
    WHERE
      actors.name = 'Sean Connery'
  SQL
end

def ford_films
  # List the films in which 'Harrison Ford' has appeared.
  execute(<<-SQL)
    SELECT
      title
    FROM
      movies
    JOIN
    (
      SELECT
        movie_id
      FROM
        castings
      JOIN
        (
          SELECT
            id
          FROM
            actors
          WHERE
            name = 'Harrison Ford'
        ) harrison
        ON castings.actor_id = harrison.id
    ) casting
    ON movies.id = casting.movie_id
  SQL
end

def ford_supporting_films
  # List the films where 'Harrison Ford' has appeared - but not in the star
  # role. [Note: the ord field of casting gives the position of the actor. If
  # ord=1 then this actor is in the starring role]
  execute(<<-SQL)
  SELECT
    title
  FROM
    movies
  JOIN
  (
    SELECT
      movie_id
    FROM
      castings
    JOIN
      (
        SELECT
          id
        FROM
          actors
        WHERE
          name = 'Harrison Ford'
      ) harrison
      ON castings.actor_id = harrison.id
    WHERE
      ord <> 1
  ) casting
  ON movies.id = casting.movie_id
  SQL
end

def films_and_stars_from_sixty_two
  # List the title and leading star of every 1962 film.
  execute(<<-SQL)
    SELECT
      title, castings.name
    FROM
      movies
      JOIN
      (
        SELECT
          movie_id, actors.name
        FROM
          castings
          JOIN
          (
            SELECT
              id, name
            FROM
              actors
          ) actors
          ON actors.id = castings.actor_id
        WHERE
          ord = 1
      ) castings
      ON id = castings.movie_id
    WHERE
      yr = 1962
  SQL
end

def travoltas_busiest_years
  # Which were the busiest years for 'John Travolta'? Show the year and the
  # number of movies he made for any year in which he made at least 2 movies.
  execute(<<-SQL)
    SELECT
      yr, COUNT(title)
    FROM
      movies
      JOIN
      (
        SELECT
          movie_id
        FROM
          castings
          JOIN
          (
            SELECT
              id
            FROM
              actors
            WHERE
              name = 'John Travolta'
          ) actors
          ON actor_id = actors.id
      ) castings
      ON id = castings.movie_id
    GROUP BY
      yr
    HAVING
      COUNT(title) >= 2
  SQL
end

def andrews_films_and_leads
  # List the film title and the leading actor for all of the films 'Julie
  # Andrews' played in.
  execute(<<-SQL)
    SELECT
      title, lead_actors.name
    FROM
      movies
      JOIN
      (
        SELECT movie_id, actors.name
        FROM
          castings
          JOIN
          (
            SELECT
              id, name
            FROM
              actors
          ) actors
          ON actor_id = actors.id
        WHERE
          ord = 1
      ) lead_actors
      ON id = lead_actors.movie_id
    WHERE
      id in
      (
        SELECT
          movie_id AS lead_name
        FROM
          castings
        JOIN
        (
          SELECT
            id, name
          FROM
            actors
          WHERE
            name = 'Julie Andrews'
        ) julie_andrews
        ON actor_id = julie_andrews.id
      )
  SQL
end

def prolific_actors
  # Obtain a list in alphabetical order of actors who've had at least 15
  # starring roles.
  execute(<<-SQL)
    SELECT
      name
    FROM
      actors
      JOIN
      (
        SELECT
          actor_id, COUNT(actor_id) AS num_lead_roles
        FROM
          castings
        WHERE
          ord = 1
        GROUP BY
          actor_id
        HAVING
          COUNT(actor_id) >= 15
      ) castings ON id = castings.actor_id
    ORDER BY
      name ASC
  SQL
end

def films_by_cast_size
  # List the films released in the year 1978 ordered by the number of actors
  # in the cast (descending), then by title (ascending).
  execute(<<-SQL)
    SELECT
      title, castings.num_actors
    FROM
      movies
      JOIN
      (
        SELECT
          movie_id, COUNT(*) AS num_actors
        FROM
          castings
        GROUP BY
          movie_id
      ) castings ON castings.movie_id = id
    WHERE
      yr = 1978
    ORDER BY
      castings.num_actors DESC,
      title ASC
  SQL
end

def colleagues_of_garfunkel
  # List all the people who have played alongside 'Art Garfunkel'.
  execute(<<-SQL)
    SELECT
      name
    FROM
      actors
      JOIN
      (
        SELECT
          actor_id
        FROM
          castings
          JOIN
          (
            SELECT
              movie_id
            FROM
              castings
              JOIN
              (
                SELECT
                  id
                FROM
                  actors
                WHERE
                  name = 'Art Garfunkel'
              ) art_id on art_id.id = actor_id
          ) art_movies ON art_movies.movie_id = castings.movie_id
      ) castings ON castings.actor_id = id
    WHERE
      name <> 'Art Garfunkel'
  SQL
end
