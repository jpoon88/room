require 'test_helper'

class FacilitiesControllerTest < ActionController::TestCase
  
  def setup
      @request.session[:user_id] = 1
  end

  
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:facilities)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_facility
    assert_difference('Facility.count') do
      post :create, :facility => { }
    end

    assert_redirected_to facility_path(assigns(:facility))
  end

  def test_should_show_facility
    get :show, :id => facilities(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => facilities(:one).id
    assert_response :success
  end

  def test_should_update_facility
    put :update, :id => facilities(:one).id, :facility => { }
    assert_redirected_to facility_path(assigns(:facility))
  end

  def test_should_destroy_facility
    assert_difference('Facility.count', -1) do
      delete :destroy, :id => facilities(:one).id
    end

    assert_redirected_to facilities_path
  end
end
