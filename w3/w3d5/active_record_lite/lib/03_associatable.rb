require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    options[:primary_key] ||= :id
    options[:foreign_key] ||= "#{name}_id".to_sym
    options[:class_name] ||= name.camelcase

    @primary_key = options[:primary_key]
    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    options[:primary_key] ||= :id
    options[:foreign_key] ||= "#{self_class_name.underscore}_id".to_sym
    options[:class_name] ||= name.singularize.camelcase

    @primary_key = options[:primary_key]
    @foreign_key = options[:foreign_key]
    @class_name = options[:class_name]
  end
end

module Associatable
  # Phase IIIb
  def belongs_to(name, options = {})
    bto = BelongsToOptions.new(name.to_s, options)
    assoc_options[name] = bto
    define_method(name.to_s) do
      foreign_key = self.send(bto.foreign_key.to_s)
      target_class = bto.model_class
      target_class.where(bto.primary_key.to_s => foreign_key).first
    end
  end

  def has_many(name, options = {})
    hmo = HasManyOptions.new(name.to_s, self.to_s, options)
    define_method(name.to_s) do
      target_class = hmo.model_class
      primary_key = self.send(hmo.primary_key)
      target_class.where(hmo.foreign_key.to_s => primary_key)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
