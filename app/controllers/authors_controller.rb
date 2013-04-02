# Controller of Authors model
class AuthorsController < ApplicationController
  
  # Security filter skip method, applied for index and show actions
  # Every user can access those actions
  
  skip_before_filter :authenticate_session, :only => [:index, :show]
  
  # Action lists all entities form database
  # GET /authors
  # GET /authors.json
  def index
    @authors = Author.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @authors }
    end
  end

  # Action shows specified entity details
  # GET /authors/1
  # GET /authors/1.json
  def show
    @author = Author.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @author }
    end
  end

  # Action which shows entity creation form
  # GET /authors/new
  # GET /authors/new.json
  def new
    @author = Author.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @author }
    end
  end

  # Action which shows Author edit form
  # GET /authors/1/edit
  def edit
    @author = Author.find(params[:id])
  end

  # Action creates new entity, using form data as parameters
  # POST /authors
  # POST /authors.json
  def create
    @author = Author.new(params[:author])

    respond_to do |format|
      if @author.save
        format.html { redirect_to @author, notice: 'Author was successfully created.' }
        format.json { render json: @author, status: :created, location: @author }
      else
        format.html { render action: "new" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action changes specified entity, using form data as parameters
  # PUT /authors/1
  # PUT /authors/1.json
  def update
    @author = Author.find(params[:id])

    respond_to do |format|
      if @author.update_attributes(params[:author])
        format.html { redirect_to @author, notice: 'Author was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action destroys specified entity
  # DELETE /authors/1
  # DELETE /authors/1.json
  def destroy
    @author = Author.find(params[:id])
    @author.destroy

    respond_to do |format|
      format.html { redirect_to authors_url }
      format.json { head :no_content }
    end
  end
end
