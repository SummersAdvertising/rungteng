class News < ActiveRecord::Base
  has_many :newsphotos, :dependent => :destroy
  attr_accessible :content, :frontshow, :name

  #delete the blank folder built by carrierwave
  before_destroy :remember_id
  after_destroy :remove_id_directory

  paginates_per 15

  protected
  def remember_id
    @id = id
  end

  def remove_id_directory
    FileUtils.remove_dir("#{Rails.root}/public/uploads/Newsphoto/#{@id}", :force => true)
  end
end
