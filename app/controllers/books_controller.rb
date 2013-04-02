# encoding: utf-8
# Controller of Books model
class BooksController < ApplicationController

  # Security filter skip method, applied for index and show actions
  skip_before_filter :authenticate_session, :only => [:index, :show, :search]
  
  # Security filter method, applied for new action.
  before_filter :is_admin?, :only => [:new]

  # Action lists all entities from database  
  # GET /books
  # GET /books.json
  def index
    @books = Book.paginate(:page => params[:page], :per_page => 10)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # Action shows specified entity details
  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # Action which shows entity creation form
  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new
    #getting associated data
    @authors = Author.all
    @categories = Category.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # Action which shows Book edit form
  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    #getting associated data
    @authors = Author.all
    @categories = Category.all
  end

  # Action creates new entity, using form data as parameters
  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])
    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Dodano wpis.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action changes specified entity, using form data as parameters
  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])
    @book.authors.destroy_all unless params[:book].has_key?('author_ids')
    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Wpis został zaktualizowany.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action destroys specified entity
  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
  # Element of search system
  # TODO
def search
  if params[:page].nil?
  params[:page] = 1
  end
  if params[:query]
    @books = Book.paginate_search(params[:query], :page => params[:page], :per_page => 10)
      else
  @books = Book.all
  end
end

end
