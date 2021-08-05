class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  enum payment: {クレジットカード: 0, 銀行振込: 1}
  enum order_status: {
    入金待ち: 1,
    入金確認: 2,
    製作中: 3,
    発送準備中: 4,
    発送済み: 5
  }

end
