# frozen_string_literal: true

# Add a password digest on users table
class AddPasswordDigestToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :password_digest, :string
  end
end
