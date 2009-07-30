require File.dirname(__FILE__) + '/../test_helper'

class PassengersControllerTest < ActionController::TestCase
	 include ApplicationHelper
	
	 fixtures :users

  def setup
    @user = users(:valid_user)
  end
  
def test_should_get_index
	 # Log in with "remember me" enabled.
    post "user/login", :user => { :screen_name => "TestUser",
                                  :password    => "test123",
                                  :remember_me => "1" }
	assert logged_in?
   # get :index
    #assert_response :success
    #assert_not_nil assigns(:passengers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_passenger
    assert_difference('Passenger.count') do
      post :create, :passenger => { }
    end

    assert_redirected_to passenger_path(assigns(:passenger))
  end

  def test_should_show_passenger
    get :show, :id => passengers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => passengers(:one).id
    assert_response :success
  end

  def test_should_update_passenger
    put :update, :id => passengers(:one).id, :passenger => { }
    assert_redirected_to passenger_path(assigns(:passenger))
  end

  def test_should_destroy_passenger
    assert_difference('Passenger.count', -1) do
      delete :destroy, :id => passengers(:one).id
    end

    assert_redirected_to passengers_path
  end
end
