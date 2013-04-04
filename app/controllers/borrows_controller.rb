# encoding: utf-8
# Controller for handling books borrow system
class BorrowsController < ApplicationController
# Security filter method, applied for admin, edit and destroy actions.
before_filter :is_admin?, :only => [:admin, :destroy, :edit]

  # GET /borrows
  # GET /borrows.json
  # Action lists all entities associated with current_user 
  def index
    @borrows = Borrow.find(:all, :conditions => {:user_id => current_user.id})
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @borrows }
    end
  end

  # Action lists all entities form database. Administrator action
  def admin
    @borrows = Borrow.all
    respond_to do |format|
      format.html # admin.html.erb
      format.json { render json: @borrows }
    end
  end

  # Currently not used
  # GET /borrows/1
  # GET /borrows/1.json
  def show
    @borrow = Borrow.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @borrow }
    end
  end

  # Action which shows entity creation form
  # GET /borrows/new
  # GET /borrows/new.json
  def new
    @borrow = Borrow.new
    @book = Book.find(params[:book_id])
    session[:book_id] = params[:book_id]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @borrow }
    end
  end

  # Action which shows Borrow edit form. Administrative action.
  # GET /borrows/1/edit
  def edit
    @borrow = Borrow.find(params[:id])
  end

  # Action creates new entity, using form data as parameters
  # POST /borrows
  # POST /borrows.json
  def create
    @borrow = Borrow.new(params[:borrow])
    #assigning fixed data to the instance of class
    @borrow.book_id = session[:book_id]
    @borrow.user_id = current_user.id
    @borrow.date_return = Time.now.to_date() + 2.weeks
    @book = Book.find(session[:book_id])
    respond_to do |format|
      if @borrow.save
        @book.available = false
        @book.save
        format.html { redirect_to @borrow, notice: 'Borrow was successfully created.' }
        format.json { render json: @borrow, status: :created, location: @borrow }
      else
        format.html { render action: "new" }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action changes specified entity, using form data as parameters
  # PUT /borrows/1
  # PUT /borrows/1.json
  def update
    @borrow = Borrow.find(params[:id])

    respond_to do |format|
      if @borrow.update_attributes(params[:borrow])
        format.html { redirect_to @borrow, notice: 'Borrow was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @borrow.errors, status: :unprocessable_entity }
      end
    end
  end

  # Action destroys specified entity. Administrative action.
  # DELETE /borrows/1
  # DELETE /borrows/1.json
  def destroy
    @borrow = Borrow.find(params[:id])
    @book = Book.find(@borrow.book_id)
    @book.available = true
    @borrow.destroy

    respond_to do |format|
      format.html { redirect_to borrows_url }
      format.json { head :no_content }
    end
  end
end
