require File.dirname(__FILE__) + '/../test_helper'
require 'menu_sidebar'

class MenuSidebarTest < Test::Unit::TestCase
  def test_load_from_yaml
    file = File.dirname(__FILE__) + '/../fixtures/menu.yml'
    assert_equal(0, MenuSidebar.cache.size)
    menu = MenuSidebar.load_from_yaml(file)
    assert_equal(6, menu.items.size)
    assert_equal(1, MenuSidebar.cache.size)
    assert_equal(file, MenuSidebar.cache.keys[0])
    assert_equal(6, MenuSidebar.cache.values[0].items.size)
    menu = MenuSidebar.load_from_yaml(file)
    assert_equal(1, MenuSidebar.cache.size)
  end
end