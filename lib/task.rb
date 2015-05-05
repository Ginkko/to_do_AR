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

end
