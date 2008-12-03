require 'test_helper'

class ComplexesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:complexes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_complex
    assert_difference('Complex.count') do
      post :create, :complex => { }
    end

    assert_redirected_to complex_path(assigns(:complex))
  end

  def test_should_show_complex
    get :show, :id => complexes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => complexes(:one).id
    assert_response :success
  end

  def test_should_update_complex
    put :update, :id => complexes(:one).id, :complex => { }
    assert_redirected_to complex_path(assigns(:complex))
  end

  def test_should_destroy_complex
    assert_difference('Complex.count', -1) do
      delete :destroy, :id => complexes(:one).id
    end

    assert_redirected_to complexes_path
  end
end
