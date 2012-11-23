require 'test_helper'

class AchievementStepsControllerTest < ActionController::TestCase
  setup do
    @achievement_step = achievement_steps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:achievement_steps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create achievement_step" do
    assert_difference('AchievementStep.count') do
      post :create, achievement_step: { achievement_id: @achievement_step.achievement_id, id: @achievement_step.id, value: @achievement_step.value }
    end

    assert_redirected_to achievement_step_path(assigns(:achievement_step))
  end

  test "should show achievement_step" do
    get :show, id: @achievement_step
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @achievement_step
    assert_response :success
  end

  test "should update achievement_step" do
    put :update, id: @achievement_step, achievement_step: { achievement_id: @achievement_step.achievement_id, id: @achievement_step.id, value: @achievement_step.value }
    assert_redirected_to achievement_step_path(assigns(:achievement_step))
  end

  test "should destroy achievement_step" do
    assert_difference('AchievementStep.count', -1) do
      delete :destroy, id: @achievement_step
    end

    assert_redirected_to achievement_steps_path
  end
end
