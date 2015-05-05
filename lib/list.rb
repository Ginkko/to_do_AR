class List
  attr_reader :name, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
  end

  def ==(other_list)
    same_name = @name == other_list.name
    same_id = @id == other_list.id
    same_name && same_id
  end

  def self.all
    lists = []
    results = DB.exec("SELECT * FROM lists;")
    results.each do |result|
      name = result.fetch("name")
      id = result.fetch("id").to_i
      lists.push(List.new({:name => name, :id => id}))
    end
    lists
  end

  def save
    result = DB.exec("INSERT INTO lists (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    result = DB.exec("SELECT * FROM lists WHERE id = #{id};")
    name = result.first().fetch("name")
    id = result.first.fetch("id").to_i
    found_list = List.new({:name => name, :id => id})
  end

  def tasks
    tasks = []
    results = DB.exec("SELECT * FROM tasks WHERE list_id = #{@id};")
    results.each() do |result|
      description = result.fetch("description")
      id = result.fetch("id").to_i
      list_id = result.fetch("list_id").to_i
      tasks.push(Task.new({:description => description, :id => id, :list_id => list_id}))
    end
    tasks
  end
end
