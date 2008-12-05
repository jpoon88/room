
class MenuSidebarItem
  attr_accessor :caption, :option_hash, :html_hash
  
  def initialize(caption, option_hash )
    @caption = caption
    @option_hash = option_hash
  end
  
end

class MenuSidebar
  attr_accessor :items

  @@cache = Hash.new do |hash, filename|
    hash[filename] = MenuSidebar.read_from_yaml(filename)
  end

  def initialize
    @items = []
  end
  
  def self.cache
    @@cache
  end

  def self.read_from_yaml(filename)
    result = MenuSidebar.new
    File.open(filename) do |f|
      YAML.load(f).each do |item_data|
        result.append_link(*item_data)
      end
    end
    result
  end

  def self.load_from_yaml(filename)
    @@cache[filename]
  end

  def append_link(caption, option)
    items << MenuSidebarItem.new(caption, option)
  end
  
  
end