class ListsController < ApplicationController
  before_action :set_list, :only => [:show, :edit, :update, :destroy]

  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def update
   if @list.update_attributes(list_params)
     redirect_to list_path(@list)
   else
     render :action => :edit
   end
  end

  def destroy
   if DateTime.current < set_list.duedate
    @list.destroy
   
    redirect_to lists_url, :notice => "Destroy Notice: 成功刪除！"
   else
    redirect_to lists_url, :alert => "Destroy Alert: OVERDUE! 無法刪除"
   end
  end

  def create
   @list = List.new(list_params)
   if @list.save
     redirect_to lists_url
   else
     render :action => :new
   end
  end 

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:name, :duedate, :note)
  end

end

