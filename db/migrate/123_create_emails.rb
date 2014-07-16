class CreateEmails < ActiveRecord::Migration
  def up
    create_table :emails do |t|
      t.string :email_subject
      t.string :email_body
    end
  end

  def down
    drop_table :emails
  end
end
