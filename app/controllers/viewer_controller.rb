class ViewerController < ApplicationController
   
   before_filter :protect
  
  def show
	@page = Page.find_by_name(params[:name])
	if  !@page.nil?
		@subpages = @page.subpages
		@title = @page.title
	else
		# there is no page variable as we are not in the wiki so go to the home page
		redirect_to :controller => "site", :action => "index"
	end
    #login_required if @page.admin?
  end
  
  def get_unformatted_text
    @page = Page.find(params[:id])
    render :text => @page.body(:source)
  end
  
  def set_page_body
    @page = Page.find(params[:id])
    @page.update_attribute(:body, params[:value])
    render :text => @page.body
  end
  
end
