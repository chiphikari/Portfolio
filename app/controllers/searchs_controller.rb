class SearchsController < ApplicationController
  def search
    @model = params["model"]
    @content = params["content"]
    @records = search_for(@model, @content)
  end

  private
  def search_for(model, content)
    if model == 'tag'
      Tag.where("tag_name LIKE ?", '%'+content+'%')
    elsif model == 'post_outside'
      PostOutside.where("address LIKE ?", '%'+content+'%')
    end
  end
end
