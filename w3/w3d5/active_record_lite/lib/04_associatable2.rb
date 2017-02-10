require_relative '03_associatable'

# Phase IV
module Associatable
  # Remember to go back to 04_associatable to write ::assoc_options

  def has_one_through(name, through_name, source_name)
    through_options = assoc_options[through_name]
    define_method(name) do
      through_table = through_options.class_name.constantize.table_name
      source_options = through_options.model_class.assoc_options[source_name]
      source_table = source_options.class_name.constantize.table_name


      result = DBConnection.execute2(<<-SQL)
        SELECT #{source_table}.*
        FROM
          #{through_table}
        JOIN
          #{source_table}
        ON #{source_table}.#{source_options.primary_key.to_s} = #{through_table}.#{source_options.foreign_key.to_s}
        WHERE
          #{through_table}.#{through_options.primary_key.to_s} = #{self.send(through_options.foreign_key.to_s)}
      SQL

      source_options.class_name.constantize.parse_all(result.drop(1)).first
    end
  end
end
