require "spec_helper"

describe(Task) do

  describe("#==") do
    it("is true for tasks with the same attributes") do
        task1 = Task.new({:description => "Wash the dog", :id => nil, :list_id => 1})
        task2 = Task.new({:description => "Wash the dog", :id => nil, :list_id => 1})
        expect(task1).to eq(task2)
      end
    end
end
