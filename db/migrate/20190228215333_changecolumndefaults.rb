class Changecolumndefaults < ActiveRecord::Migration[5.2]
  def change
    change_column :lists, :finished, :boolean, default: false
    change_column :tasks, :finished, :boolean, default: false
    change_column :lists, :priority_number, :integer, default: 0
    change_column :tasks, :priority_number, :integer, default: 0
  end
end
