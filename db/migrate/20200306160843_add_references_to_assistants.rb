class AddReferencesToAssistants < ActiveRecord::Migration[6.0]
  def change
    add_reference :assistants, :user, foreign_key: true
  end
end
