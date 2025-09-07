require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @todo = todos(:one)
  end

  test "should get index" do
    sign_in_as users(:one)
    get todos_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as users(:one)
    get new_todo_url
    assert_response :success
  end

  test "should create todo" do
    sign_in_as users(:one)
    assert_difference("Todo.count") do
      post todos_url, params: { todo: { title: @todo.title, description: @todo.description, completed: @todo.completed } }
    end
    assert_redirected_to todo_url(Todo.last)
  end

  test "should show todo" do
    sign_in_as users(:one)
    get todo_url(@todo)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as users(:one)
    get edit_todo_url(@todo)
    assert_response :success
  end

  test "should update todo" do
    sign_in_as users(:one)
    patch todo_url(@todo), params: { todo: { title: @todo.title, description: @todo.description, completed: @todo.completed } }
    assert_redirected_to todo_url(@todo)
  end

  test "should destroy todo" do
    sign_in_as users(:one)
    assert_difference("Todo.count", -1) do
      delete todo_url(@todo)
    end
    assert_redirected_to todos_url
  end

  test "should toggle completed status" do
    sign_in_as users(:one)
    patch toggle_complete_todo_url(@todo)
    assert_redirected_to todos_url
    @todo.reload
    assert @todo.completed?
  end

  # Test unauthenticated access - should redirect to login
  test "should redirect to login when accessing index without authentication" do
    get todos_url
    assert_redirected_to new_session_path
  end

  test "should redirect to login when accessing new without authentication" do
    get new_todo_url
    assert_redirected_to new_session_path
  end

  test "should redirect to login when creating todo without authentication" do
    assert_no_difference("Todo.count") do
      post todos_url, params: { todo: { title: "Test Todo", description: "Test Description", completed: false } }
    end
    assert_redirected_to new_session_path
  end

  test "should redirect to login when showing todo without authentication" do
    get todo_url(@todo)
    assert_redirected_to new_session_path
  end

  test "should redirect to login when accessing edit without authentication" do
    get edit_todo_url(@todo)
    assert_redirected_to new_session_path
  end

  test "should redirect to login when updating todo without authentication" do
    patch todo_url(@todo), params: { todo: { title: "Updated", description: "Updated", completed: true } }
    assert_redirected_to new_session_path
  end

  test "should redirect to login when destroying todo without authentication" do
    assert_no_difference("Todo.count") do
      delete todo_url(@todo)
    end
    assert_redirected_to new_session_path
  end

  test "should redirect to login when toggling completion without authentication" do
    patch toggle_complete_todo_url(@todo)
    assert_redirected_to new_session_path
  end
end
