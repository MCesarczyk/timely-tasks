require "test_helper"

class TaskTest < ActiveSupport::TestCase
  test "fixture tasks are valid" do
    assert tasks(:one).valid?
    assert tasks(:two).valid?
  end

  test "title must be present" do
    task = Task.new(content: "No title", completed: false)
    assert_not task.valid?
    assert_includes task.errors[:title], "can't be blank"
  end

  test "completed can be true or false" do
    assert_includes [true, false], tasks(:one).completed
    assert_includes [true, false], tasks(:two).completed
  end

  test "content can be blank" do
    task = Task.new(title: "Test", content: "Lorem ipsum", completed: false)
    assert task.valid?
  end
end
