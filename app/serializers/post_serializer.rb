class PostSerializer < ActiveModel::Serializer

  attributes :id, :title, :body, :images
  
  def images
    self.object.images.map do |e|
      ImageSerializer.new(e).attributes
    end
  end
end
