# frozen_string_literal: true

class AddParentIdToGame < ActiveRecord::Migration[6.0]
  def change
    create_table :expansions do |_t|
      t.references :parent, index: true
      t.timestamps
    end
  end
end
