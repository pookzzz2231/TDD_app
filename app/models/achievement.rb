class Achievement < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true
  validates :user, presence: true
  validates :title, uniqueness: {
    scope: "user_id",
    message: "You already have the same title"
  }

  enum privacy: [:public_access, :private_access, :friends_access]

  def description_html
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(description).html_safe
  end

  def author
    "#{title} #{user.email}"
  end
end