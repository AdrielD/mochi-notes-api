Mongoid.load!(File.join(File.dirname(__FILE__), 'mongoid.yml'))

Mongoid::Fields.option :fixed_length do |model, field, value|
  model.validates_length_of field.name, is: value
end

Mongoid::Fields.option :max_length do |model, field, value|
  model.validates_length_of field.name, maximum: value
end
