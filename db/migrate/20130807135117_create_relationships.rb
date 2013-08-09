class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
    	t.belongs_to :user, class_name: 'User'
  		t.belongs_to :friend, class_name: 'User'
  		t.binary       :status, default: 0  	#0=pending
  												#1=accepted
  												#2=declined	
    end
  end
end