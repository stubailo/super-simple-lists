class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy, 
    :permissions, 
    :add_permission, 
    :remove_permission
  ]

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
    @notes = @list.notes.order("updated_at DESC")
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
  
  # POST /lists/1/permissions
  def add_permission
    authorize! :permissions, @list
    user = User.find_by_email(params[:email])
    level = params[:level]

    # check if user exists
    if not user
      redirect_to permissions_list_path(@list), :alert => "user with email #{params[:email]} doesn't exist"

    # check if permissions level is valid
    elsif not ["owner", "edit", "read"].include? level
      redirect_to permissions_list_path(@list), :alert => "invalid permissions level: #{level}"

    # make sure a list always has an owner
    elsif @list.owners.include? user and @list.owners.count == 1
      redirect_to permissions_list_path(@list), :alert => "can't remove the only owner"

    # add the permissions!
    else

      # remove any other permissions the user may have had to avoid duplicates
      @list.users.delete user

      # see the list model file to see how the syntax below works
      case level
      when "owner"
        @list.owners << user
      when "edit"
        @list.editors << user
      when "read"
        @list.readers << user
      end

      redirect_to permissions_list_path(@list), :notice => "added #{params[:email]} with #{level} permissions"
    end
  end

  # DELETE /lists/1/permissions
  def remove_permission
    authorize! :permissions, @list
    user = User.find_by_email(params[:email])

    # make sure user exists
    if not user
      redirect_to permissions_list_path(@list), :alert => "user with email #{params[:email]} doesn't exist"
    else
      # remove the user from the list
      @list.users.delete user
      redirect_to permissions_list_path(@list), :notice => "removed permissions for #{user.email}"
    end
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
