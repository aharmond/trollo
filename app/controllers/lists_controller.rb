class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update, :destroy]
  before_action :set_board

  def index
    redirect_to board_path(@board)
  end

  def show
  end

  def new
    @list = @board.lists.new
  end

  def create
    @list = @board.lists.new(list_params)

    if @list.save
      redirect_to board_lists_path(@board)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @list.update(list_params)
      redirect_to board_list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    @list.destroy
    redirect_to board_lists_path(@board)
  end

  private
  
    def set_board
      if params[:board_id] != nil
        @board = Board.find(params[:board_id])
      else
        @board = Board.find(@list.board_id)
      end
    end

    def set_list
      @list = List.find(params[:id])
    end

    def list_params
      params.require(:list).permit(:name, :finished, :priority_number)
    end
end
