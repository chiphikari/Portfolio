class SearchsController < ApplicationController
  def search
    @model = params['model']
    @content = params['content']
    @records = search_for(@model, @content)
  end

  private

  def search_for(model, content)
    if model == 'tag'
      PostSummary.joins(:tags).where("tags.tag_name like ?",'%' + content + '%').distinct
    elsif model == 'post_outside'
      PostOutside.where('address LIKE ?', '%' + content + '%')
    end
  end
end
