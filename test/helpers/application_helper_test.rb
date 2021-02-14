class ApplicationHelperTest < ActionView::TestCase
  test "title helper" do
    assert_equal title_helper,        "Ruby on rails tutorial sample app"        
    assert_equal title_helper("Help"), "Help | Ruby on rails tutorial sample app"
  end
end
