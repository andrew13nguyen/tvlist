class HomeController < ApplicationController
  # layout "category"

  def index
  end

  # def show
  #   category_db_name = @template.get_category_name(params[:category], 'db_name') #category from database
  # 
  #   unless category_db_name.nil?
  #     @category = params[:category] #seo category
  # 
  #     if @category == 'all'
  #       @billers_popularity = Biller.list_all_ordered_by_popularity
  #     else
  #       @billers_popularity = Biller.list_all_by_category_ordered_by_popularity(category_db_name)
  #     end
  # 
  #     @category_count_list = @template.category_menu
  # 
  #     @page_title = @template.page_title(@category)
  #   else
  #     redirect_to :controller => "home", :action => "index"
  #   end
  # end

end