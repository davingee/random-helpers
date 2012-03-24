#   make something self
#   irb Class.first
#   control d to go back back

def facebook_like(url=root_url)
  content_tag :iframe, nil, :src => "http://www.facebook.com/plugins/like.php?href=#{CGI::escape(url)}&layout=standard&show_faces=false&width=450&action=like&font=arial&colorscheme=dark&height=30", :scrolling => 'no', :frameborder => '0', :allowtransparency => true, :id => :facebook_like
end
<%= facebook_like(request.url) %>
<%= facebook_like %>


require 'digest'
def gravatar(email=current_user.email)
  image_tag("http://www.gravatar.com/avatar.php?gravatar_id=#{Digest::MD5::hexdigest(email)}", :alt => 'Avatar', :class => 'avatar')
end
<%= gravatar(current_user.email) %>
<%= gravatar %>


def self.search(search)
  if search
    joins(:rumor).where( [ "rumors.content ILIKE ?", "%#{search}%" ] )
  else
    scoped
  end
end


class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation 
  attr_accessor :friends 
  has_many :stories
  has_many :plots
  has_many :characters
end
 
class Story < ActiveRecord::Base
  has_many :characters
  has_many :plots
  belongs_to :user
end
 
class Character < ActiveRecord::Base
  belongs_to :user
  belongs_to :story
  has_many :character_plots
  has_many :plots, :through => :character_plots
end
 
class CharacterPlot < ActiveRecord::Base
  belongs_to :plot
  belongs_to :character
end
 
class Plot < ActiveRecord::Base
  has_many :character_plots
  has_many :characters, :through => :character_plots
  belongs_to :story
  belongs_to :user
end
