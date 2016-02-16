require 'test_helper'

class ScrapesControllerTest < ActionController::TestCase
  setup do
    @scrape = scrapes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scrapes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scrape" do
    assert_difference('Scrape.count') do
      post :create, scrape: { description: @scrape.description, image: @scrape.image, locale: @scrape.locale, page_type: @scrape.page_type, site_name: @scrape.site_name, title: @scrape.title, url: @scrape.url }
    end

    assert_redirected_to scrape_path(assigns(:scrape))
  end

  test "should show scrape" do
    get :show, id: @scrape
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scrape
    assert_response :success
  end

  test "should update scrape" do
    patch :update, id: @scrape, scrape: { description: @scrape.description, image: @scrape.image, locale: @scrape.locale, page_type: @scrape.page_type, site_name: @scrape.site_name, title: @scrape.title, url: @scrape.url }
    assert_redirected_to scrape_path(assigns(:scrape))
  end

  test "should destroy scrape" do
    assert_difference('Scrape.count', -1) do
      delete :destroy, id: @scrape
    end

    assert_redirected_to scrapes_path
  end
end
