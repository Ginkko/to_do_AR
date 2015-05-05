require "./lib/list"
require "./lib/task"
require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require "pg"

DB = PG.connect({:dbname => "to_do"})

get('/') do
  erb(:index)
end

get('/lists') do
  @lists = List.all()
  erb(:lists)
end

get('/list/new') do
  erb(:list_form)
end

post('/lists') do
  name = params.fetch("name")
  new_list = List.new({:name => name, :id => nil})
  new_list.save()
  @lists = List.all()
  erb(:lists)
end
