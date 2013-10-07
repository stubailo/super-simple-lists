class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, :permissions]

  # get /lists
  # get /lists.json
  def index
    authorize! :show, List
    @lists = current_user.lists
  end
  
  # get /lists_fancy
  # get /lists.json
  def index_fancy
    authorize! :show, List
    @lists = current_user.lists
    render "lists/index_fancy", :layout => false
  end

  # GET /lists/1
  # GET /lists/1.json
  def show
    authorize! :show, @list
  end

  # GET /lists/new
  def new
    authorize! :new, List
    @list = List.new
  end

  # GET /lists/1/permissions
  def permissions
    authorize! :permissions, @list
  end

  # GET /lists/1/edit
  def edit
    authorize! :edit, @list
  end

  # POST /lists
  # POST /lists.json
  def create
    authorize! :create, List
    respond_to do |format|
      begin
        @list = current_user.owned_lists.create!(list_params)
        format.html { redirect_to @list, notice: 'List was successfully created.' }
        format.json { render action: 'show', status: :created, location: @list }
      rescue
        format.html { render action: 'new' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    authorize! :update, @list

    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: 'List was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lists/1
  # DELETE /lists/1.json
  def destroy
    @list.destroy
    respond_to do |format|
      format.html { redirect_to lists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = List.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:name)
    end
end
