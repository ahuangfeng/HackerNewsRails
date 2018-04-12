require 'test_helper'

class SubmitsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @submit = submits(:one)
  end

  test "should get index" do
    get submits_url
    assert_response :success
  end

  test "should get new" do
    get new_submit_url
    assert_response :success
  end

  test "should create submit" do
    assert_difference('Submit.count') do
      post submits_url, params: { submit: { text: @submit.text, title: @submit.title, url: @submit.url } }
    end

    assert_redirected_to submit_url(Submit.last)
  end

  test "should show submit" do
    get submit_url(@submit)
    assert_response :success
  end

  test "should get edit" do
    get edit_submit_url(@submit)
    assert_response :success
  end

  test "should update submit" do
    patch submit_url(@submit), params: { submit: { text: @submit.text, title: @submit.title, url: @submit.url } }
    assert_redirected_to submit_url(@submit)
  end

  test "should destroy submit" do
    assert_difference('Submit.count', -1) do
      delete submit_url(@submit)
    end

    assert_redirected_to submits_url
  end
end
