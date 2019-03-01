class List < ApplicationRecord
  belongs_to :board
  has_many :tasks, dependent: :destroy

  def self.single_list(list_id)
    List.find_by_sql(["
      SELECT *
      FROM lists AS l
      WHERE l.id = ?
    ", list_id]).first
  end

  def self.create_list(p, id)
    List.find_by_sql(["
      INSERT INTO lists (name, board_id, created_at, updated_at)
      VALUES (:name, :board_id, :created_at, :updated_at)
    ", {
        name: p[:name],
        board_id: id,
        created_at: DateTime.now,
        updated_at: DateTime.now
    }])
  end

  def self.update_list(list_id, p)
    List.find_by_sql(["
      UPDATE lists AS l
      SET name = ?, finished = ?, priority_number = ?, updated_at = ?
      WHERE l.id = ?
    ;", p[:name], p[:finished], p[:priority_number], DateTime.now, list_id])
  end

  def self.delete_list(list_id)
    Task.find_by_sql(["
      DELETE FROM tasks AS t
      WHERE t.list_id = ?
    ;", list_id])

    List.find_by_sql(["
      DELETE FROM lists AS l
      WHERE l.id = ?
    ;", list_id])
  end
end
