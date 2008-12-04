
class MenuSidebarItem
  attr_accessor :caption, :option_hash, :html_hash
  
  def initialize(caption, option_hash )
    @caption = caption
    @option_hash = option_hash
  end
  
end

class MenuSidebar
  attr_accessor :items


  def initialize
    @items = []
  end



  def self.load_from_yaml(filename)
    result = MenuSidebar.new
    File.open(filename) do |f|
      YAML.load(f).each do |item_data|
        result.append_link(*item_data)
      end
    end
    result
  end

  def append_link(caption, option)
    items << MenuSidebarItem.new(caption, option)
  end
  
  
end