module ApplicationHelper
  include Flot

 def title
    @title.nil? ? 'ThousandSoft' : @title
  end

  def logo
    image_tag("logo.png", :alt => "ThousandSoft", :class => "round")
  end
end
