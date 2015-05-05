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

get('/list/:id') do
  @list = List.find(params.fetch('id'))
  erb(:tasks)
end

post('/lists') do
  name = params.fetch("name")
  new_list = List.new({:name => name, :id => nil})
  new_list.save()
  @lists = List.all()
  erb(:lists)
end

get('/list/:id/new') do
  @list = List.find(params.fetch('id'))
  erb(:task_form)
end

post('/list/:id') do
  description = params.fetch("description")
  list_id = params.fetch("id").to_i
  new_task = Task.new({:description => description, :list_id => list_id, :id => nil})
  new_task.save
  @list = List.find(list_id)
  erb(:tasks)
end
