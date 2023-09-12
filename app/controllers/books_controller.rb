class BooksController < ApplicationController
      before_action :authenticate_user!

  def show
    @books = Book.find(params[:id])
    @user = @books.user
    @book = Book.new
    @book_comment = BookComment.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user

    if params[:latest]
    @books = Book.latest
    elsif params[:old]
    @books = Book.old
    elsif params[:star_count]
    @books = Book.star_count
    else
    @books = Book.all
    end

    to = Time.current.at_end_of_day
    from = (to - 6.day).at_beginning_of_day
    @books = Book.includes(:favorited_users).
      sort_by {|x|
        x.favorited_users.includes(:favorites).where(created_at: from...to).size
      }.reverse
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
     @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
     redirect_to books_path
     end
  end

  def update
     @book = Book.find(params[:id])
     unless @book.user.id == current_user.id
     redirect_to books_path
     end
     if @book.update(book_params)
     flash[:notice] = "Book was successfully updated."
     redirect_to book_path(@book.id)
     else
     @books = Book.all
     render :edit
     end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :star, :category)
  end

end