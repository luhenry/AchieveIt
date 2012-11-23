require 'test_helper'

class DeveloperProjectsControllerTest < ActionController::TestCase
  setup do
    @developer_project = developer_projects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:developer_projects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create developer_project" do
    assert_difference('DeveloperProject.count') do
      post :create, developer_project: { developer_id: @developer_project.developer_id, project_id: @developer_project.project_id }
    end

    assert_redirected_to developer_project_path(assigns(:developer_project))
  end

  test "should show developer_project" do
    get :show, id: @developer_project
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @developer_project
    assert_response :success
  end

  test "should update developer_project" do
    put :update, id: @developer_project, developer_project: { developer_id: @developer_project.developer_id, project_id: @developer_project.project_id }
    assert_redirected_to developer_project_path(assigns(:developer_project))
  end

  test "should destroy developer_project" do
    assert_difference('DeveloperProject.count', -1) do
      delete :destroy, id: @developer_project
    end

    assert_redirected_to developer_projects_path
  end
end
