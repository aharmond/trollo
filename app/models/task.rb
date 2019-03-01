class Task < ApplicationRecord
  belongs_to :list

  def self.single_task(task_id)
    Task.find_by_sql(["
      SELECT *
      FROM tasks AS t
      WHERE t.id = ?
    ", task_id]).first
  end

  def self.create_task(p, id)
    Task.find_by_sql(["
      INSERT INTO tasks (name, list_id, created_at, updated_at)
      VALUES (:name, :list_id, :created_at, :updated_at)
    ", {
        name: p[:name]
        list_id: id,
        created_at: DateTime.now
        updated_at: DateTime.now
    }])
  end

  def self.update_task(task_id, p)
    Task.find_by_sql(["
    UPDATE tasks AS t
    SET name = ?, finished = ?, priority_number = ?, updated_at = ?
    WHERE t.id = ?
    ;", p[:name], p[:finished], p[:priority_number], DateTime.now, task_id])
  end

  def self.delete_task(task_id)
    Task.find_by_sql(["
      DELETE FROM tasks AS t
      WHERE t.id = ?
    ;", task_id])
  end
end
