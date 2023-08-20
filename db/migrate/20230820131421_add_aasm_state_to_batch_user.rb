class AddAasmStateToBatchUser < ActiveRecord::Migration[7.0]
  def change
    add_column :batch_users, :aasm_state, :string
  end
end
