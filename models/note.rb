class Note
  include Mongoid::Document
  include Mongoid::Timestamps

  field :author_uuid, type: String, fixed_length: 36
  field :text, type: String, default: '', max_length: 1000

  # index text: 'text'
  # index({ author_uuid: 1 }, { name: 'author_uuid_index' })

  def as_json
    attrs = attributes.dup
    attrs['id'] = attrs['_id'].to_s
    attrs.except('_id')
  end
end
