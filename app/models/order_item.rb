class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: {
    着手不可: 1,
    製作待ち: 2,
    製作中: 3,
    制作完了: 4,
  }

end
