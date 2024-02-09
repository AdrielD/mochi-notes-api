require 'sinatra'
require 'sinatra/json'
require 'mongoid'
require './config/mongoid'
require './models/note'

set :default_content_type, :json
# set :environment, :development

get '/health_check' do
  json 'message': 'Meow! This API seems to be working in order!'
end

get '/notes' do
  notes = Note.all
  json notes.as_json
end

get '/author/:id/notes' do
  notes = Note.where(author_uuid: params['id'])
  json notes.as_json
end

get '/notes/:id' do
  note = Note.find(params['id'])
  json note.as_json
end

post '/notes' do
  note = Note.create!(
    author_uuid: params['author_uuid'],
    text: params['text']
  )
  json note.as_json
end

put '/notes/:id' do
  note = Note.find(params['id'])
  note.text = params['text']
  note.save
  json note.as_json
end

delete '/notes/:id' do
  note = Note.find(params['id'])
  note.destroy
  json note.as_json
end

not_found do
  json 'message': 'Meow... this route does not exist.'
end

# error Mongoid::Errors::DocumentNotFound do
  # status 404
# error do
#   puts '---------------------------------'
#   puts 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
#   json 'error': env['sinatra.error'].message
# end
