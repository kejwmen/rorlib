# encoding: utf-8
# Categories controller
class CategoriesController < ApplicationController

  # Skipping security filter for common actions
  skip_before_filter :authenticate_session, :only => [:index, :show]

  # Action lists all entities from database
  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # Action shows specified entity details
  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # Action which shows entity creation form
  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # Action which shows Book edit form
  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # Action creates new entity, using form data as parameters
  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Kategoria została utworzona.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action changes specified entity, using form data as parameters
  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Kategoria została zaktualizowana.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action destroys specified entity
  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end
end
