# frozen_string_literal: true

require 'test_helper'

class SignUpProcessTest < ActionDispatch::IntegrationTest
  test 'get sign_up form and create user' do
    get '/signup'
    assert_response :success
    assert_difference('User.count', 1) do
      post users_path, params: { user: { username: 'Bob Marley', email: 'bob@marley.com', password: '123Soleil' } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match 'Welcome to the alpha blog !', response.body
  end
  test 'get sign_up form and invalid user creation (too short)' do
    get '/signup'
    assert_response :success
    assert_no_difference('User.count') do
      post users_path, params: { user: { username: 'aa', email: 'bob-marley.com', password: '' } }
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match 'Errors', response.body
    assert_match 'Username is too short', response.body
    assert_match 'Email is invalid', response.body
    assert_match 'Password can', response.body
    assert_match 'be blank', response.body
  end
  test 'get sign_up form and invalid user creation (too long)' do
    get '/signup'
    assert_response :success
    assert_no_difference('User.count') do
      post users_path,
           params: { user: { username: 'aaaaa bbbbb ccccc ddddd eeeee', email: 'bob@marley.com',
                             password: '123Soleil' } }
    end
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    assert_match 'Errors', response.body
    assert_match 'Username is too long', response.body
  end
end
