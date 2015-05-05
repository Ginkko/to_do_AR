require "spec_helper"

describe(List) do

  describe("#save") do
    it("add the list to the database") do
      test_list = List.new({:name => "new list", :id => nil})
      test_list.save()
      expect(List.all()).to(eq([test_list]))
    end
  end

  describe("#==") do
    it("is true for lists with the same name and id") do
      list1 = List.new({:name => "new list", :id => nil})
      list2 = List.new({:name => "new list", :id => nil})
      expect(list1).to(eq(list2))
    end
  end


end
