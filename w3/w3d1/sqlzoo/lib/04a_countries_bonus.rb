# == Schema Information
#
# Table name: countries
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

# BONUS QUESTIONS: These problems require knowledge of aggregate
# functions. Attempt them after completing section 05.

def highest_gdp
  # Which countries have a GDP greater than every country in Europe? (Give the
  # name only. Some countries may have NULL gdp values)
  execute(<<-SQL)
    SELECT
      name
    FROM
      countries
    WHERE
      gdp >
      (
          SELECT
            MAX(gdp)
          FROM
            countries
          WHERE
            continent = 'Europe'
          GROUP BY
            continent
      )
  SQL
end

def largest_in_continent
  # Find the largest country (by area) in each continent. Show the continent,
  # name, and area.
  execute(<<-SQL)
    SELECT
      continent, name, area
    FROM
      countries
    WHERE
      area IN
      (
        SELECT
          MAX(area)
        FROM
          countries
        GROUP BY
          continent
      )
  SQL
end

def large_neighbors
  # Some countries have populations more than three times that of any of their
  # neighbors (in the same continent). Give the countries and continents.
  execute(<<-SQL)
    SELECT
      name, countries.continent
    FROM
      countries
      JOIN
      (
        SELECT
          countries.continent, 3 * MAX(population) as triple_population
        FROM
          countries
        JOIN
        (
          SELECT
            countries.continent, MAX(population) as max_population
          FROM
            countries
          GROUP BY
            countries.continent
        ) max_population
          ON countries.continent = max_population.continent
        WHERE
          population < max_population.max_population
        GROUP BY
          countries.continent
      ) triple
      ON countries.continent = triple.continent
    WHERE
      population > triple.triple_population

  SQL
end
