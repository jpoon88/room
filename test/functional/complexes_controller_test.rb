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
    
    assert_select("form[action=?]", complexes_path) do
      assert_select "input[name *=title]"
      assert_select "input[name *=created_by]"
      assert_select "input[name *=modified_by]"      
    end
  end

  def test_should_create_complex
    complex_hash = { :title => "Bayview Elementary",
      :created_by => 1, :modified_by => 1} 
    
    assert_difference('Complex.count') do
      post :create, :complex => complex_hash
    end

    expected_complex = Complex.new(complex_hash)
    new_complex = Complex.find(:all, :order => "id DESC", :limit => 1)[0]
    expected_complex[:id] = new_complex[:id]
    expected_complex[:created_at] = new_complex[:created_at]
    expected_complex[:updated_at] = new_complex[:updated_at]
    assert_equal(expected_complex, new_complex)

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
