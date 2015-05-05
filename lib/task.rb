class Task
  attr_reader :description, :id, :list_id

  def initialize(attributes)
    @description = attributes.fetch(:description)
    @id = attributes.fetch(:id)
    @list_id = attributes.fetch(:list_id)
  end

  def ==(other_task)
    same_desc = @description == other_task.description
    same_id = @id == other_task.id
    same_list_id = @list_id == other_task.list_id
    same_desc && same_id && same_list_id
  end

  def self.all
    tasks = []
    results = DB.exec("SELECT * FROM tasks;")
    results.each do |result|
      description = result.fetch("description")
      id = result.fetch("id").to_i
      list_id = result.fetch("list_id").to_i
      tasks.push(Task.new({:description => description, :id => id, :list_id => list_id}))
    end
    tasks
  end

  def save
    result = DB.exec("INSERT INTO tasks (description, list_id) VALUES ('#{@description}', #{@list_id}) RETURNING id;")
    @id = result.first.fetch("id").to_i
  end

end
