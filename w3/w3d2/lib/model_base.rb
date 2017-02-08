require 'sqlite3'
require 'active_support/inflector'

class ModelBase
  def self.find_by_id(id)
    query_name = "SELECT * FROM #{self.to_s.pluralize.downcase} WHERE id = #{id}"
    data = QuestionDBConnection.instance.execute(query_name)
    return nil if data.length == 0
    self.new(data[0])
  end

  def self.all
    query_name = "SELECT * FROM #{self.to_s.pluralize.downcase}"
    data = QuestionDBConnection.instance.execute(query_name)
    return nil if data.length == 0
    data.map { |el| self.new(el)}
  end

  def self.where(options)
    table_name = self.to_s.pluralize.downcase
    query_string = "SELECT * FROM #{table_name} WHERE "

    if options.is_a? (Hash)
      keys = options.keys.map do |key|
        "#{key} = ?"
      end.join(" AND ")
      query_string << keys
      data = QuestionDBConnection.instance.execute(query_string, *options.values)
    elsif options.is_a? (String)
      query_string << options
      data = QuestionDBConnection.instance.execute(query_string)
    else
      raise "must be passed a hash or a string!"
    end

    return nil if data.length == 0
    data.map { |el| self.new(el) }

  end

  def self.method_missing(method_name, *args)
    method_name = method_name.to_s
    if method_name.start_with?("find_by_")

      attributes_string = method_name[("find_by_".length)..-1]
      attribute_names = attributes_string.split("_and_")

      unless attribute_names.length == args.length
        raise "unexpected # of arguments"
      end

      options = {}
      attribute_names.each_index do |i|
        options[attribute_names[i]] = args[i]
      end

      self.where(options)
    else
      raise "no such method"
    end
  end

  def save
    table_name = self.class.to_s.pluralize.downcase
    variable_names = self.instance_variables
    variable_names.shift
    instance_variables = variable_names.map { |el| eval(el.to_s) }

    if @id
      set_string = variable_names.map { |el| "#{el.to_s[1..-1]} = ?" }.join(", ")
      query_string = "UPDATE #{table_name} SET #{set_string} WHERE id = ?"
      QuestionDBConnection.instance.execute(query_string, *instance_variables, @id)
    else
      insert_string = variable_names.map { |el| el.to_s[1..-1] }.join(", ")
      question_marks = "#{instance_variables.map { |_| "?"}.join(", ")}"
      query_string = "INSERT INTO #{table_name} (#{insert_string}) VALUES (#{question_marks})"

      QuestionDBConnection.instance.execute(query_string, *instance_variables)

      @id = QuestionDBConnection.instance.last_insert_row_id
    end
    @id
  end
end
