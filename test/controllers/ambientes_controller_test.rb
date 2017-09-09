require 'test_helper'

class AmbientesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ambiente = ambientes(:one)
  end

  test "should get index" do
    get ambientes_url
    assert_response :success
  end

  test "should get new" do
    get new_ambiente_url
    assert_response :success
  end

  test "should create ambiente" do
    assert_difference('Ambiente.count') do
      post ambientes_url, params: { ambiente: { grupo_id: @ambiente.grupo_id, nome: @ambiente.nome } }
    end

    assert_redirected_to ambiente_url(Ambiente.last)
  end

  test "should show ambiente" do
    get ambiente_url(@ambiente)
    assert_response :success
  end

  test "should get edit" do
    get edit_ambiente_url(@ambiente)
    assert_response :success
  end

  test "should update ambiente" do
    patch ambiente_url(@ambiente), params: { ambiente: { grupo_id: @ambiente.grupo_id, nome: @ambiente.nome } }
    assert_redirected_to ambiente_url(@ambiente)
  end

  test "should destroy ambiente" do
    assert_difference('Ambiente.count', -1) do
      delete ambiente_url(@ambiente)
    end

    assert_redirected_to ambientes_url
  end
end
