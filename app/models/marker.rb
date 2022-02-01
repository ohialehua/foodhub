class Marker < ApplicationRecord

  belongs_to :store
  belongs_to :enduser

  def self.sort(selection)
	  if selection == 'old'
	    @markers = Marker.all.order(created_at: :ASC)
	  elsif selection == 'new'
	    @markers = Marker.all.order(created_at: :DESC)
	  else
	    @markers = Marker.all.order(created_at: :DESC)
	    # @markers = Marker.joins(:enduser).where(enduser_id: Enduser.where(store_order_id: ).ids).order(Arel.sql("store_orders DESC"))
    end
	end
end
