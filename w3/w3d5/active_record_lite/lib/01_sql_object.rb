require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @columns ||= DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    .first.map { |el| el.to_sym }
  end

  def self.finalize!
    self.columns.each do |column|
      define_method(column) do
        self.attributes[column]
      end
      define_method("#{column.to_s}=".to_sym) do |val|
        self.attributes[column] = val
      end
    end
  end

  def self.table_name=(table_name)
    table_name ||= self.to_s.pluralize.tableize
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.to_s.pluralize.tableize
  end

  def self.all
    results = DBConnection.execute2(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
    SQL
    results = results.drop(1)
    self.parse_all(results)
  end

  def self.parse_all(results)
    parsed_results = []
    results.each do |row|
      parsed_results << self.new(row)
    end
    parsed_results
  end

  def self.find(id)
    result = DBConnection.execute2(<<-SQL)
      SELECT
        #{self.table_name}.*
      FROM
        #{self.table_name}
      WHERE
        id = #{id}
      LIMIT
        1
    SQL
    result = result.drop(1)
    parse_all(result).first
  end

  def initialize(params = {})
    columns = self.class.columns
    params.each do |k, v|
      attr_name = k.to_sym
      raise "unknown attribute '#{attr_name}'" unless columns.include?(attr_name)
      send("#{attr_name}=", v)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    self.class.columns.map do |col|
      @attributes[col]
    end
  end

  def insert
    col_names_arr = self.class.columns.map { |el| el.to_s }
    col_names = col_names_arr.join(", ")
    question_marks = col_names_arr.map { |el| "?"}.join(", ")

    DBConnection.execute2(<<-SQL, *self.attribute_values)
      INSERT INTO
        #{self.class.table_name}(#{col_names})
      VALUES
        (#{question_marks})
    SQL
    self.id = DBConnection.last_insert_row_id
  end

  def update
    col_names_arr = self.class.columns.map { |el| "#{el.to_s} = ?"}
    col_names = col_names_arr.join(", ")

    DBConnection.execute2(<<-SQL, *self.attribute_values)
      UPDATE
        #{self.class.table_name}
      SET
        #{col_names}
      WHERE
        id = #{self.id}
    SQL
  end

  def save
    self.id.nil? ? insert : update
  end
end
