class Board < ApplicationRecord
  belongs_to :user
  has_many :lists, dependent: :destroy

  def self.all_boards(id)
    Board.find_by_sql("
      SELECT *
      FROM boards AS b
      WHERE b.user_id = #{id}
    ")
  end

  def self.single_board(user_id, board_id)
    Board.find_by_sql(["
      SELECT *
      FROM boards AS b
      WHERE b.id = ? AND b.user_id = ?
    ", board_id, user_id]).first
  end

  def self.create_board(p, id)
    Board.find_by_sql(["
      INSERT INTO boards (name, user_id, created_at, updated_at)
      VALUES (:name, :user_id, :created_at, :updated_at);
    ", {
        name: p[:name],
        user_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
    }])
  end

  def self.update_board(board_id, p)
    Board.find_by_sql(["
      UPDATE boards AS b
      SET name = ?, updated_at = ?
      WHERE b.id = ?
    ;", p[:name], DateTime.now, board_id])
  end

  def self.delete_board(board_id)
    @board = Board.find(board_id)

    @board.lists.each do |list|
      list.tasks.each do |task|
        task.destroy
      end
    end

    List.find_by_sql(["
      DELETE FROM lists AS l
      WHERE l.board_id = ?
    ;", board_id])

    Board.find_by_sql(["
      DELETE FROM boards AS b
      WHERE b.id = ?
    ;", board_id])
  end
end
