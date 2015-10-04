class Booking < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  def base_uri
    root_path(self)
  end

  PAYU_PARAMS = {
      key: 'gtKFFx',
      salt: 'eCwWELxi',
      surl: 'http://localhost:3000/bookings/payment_success',
      furl: "#{Rails.application.routes.url_helpers.root_path}bookings/payment_fail",
      bankcode: 'payuw',
      pg: 'wallet'
  }
  # PAYU = ["gtKFFx", "eCwWELxi","http://localhost:3000/bookings/payment_success",
  #         "#{Rails.application.routes.url_helpers.root_path}bookings/payment_fail","payu_paisa"]
  belongs_to :user
  has_many :Booking_times
end


# <%= f.hidden_field :key, value: Post::PAYU[:key], name: "key" %>
# <%= f.hidden_field :salt, value: Post::PAYU[:salt], name: "salt" %>
# <%= f.text_field :txnid, value: Post::PAYU[:txnid], name: "txnid" %>
# <%= f.text_field :amount, value: Post::PAYU[:amount], name: "amount" %>
# <%= f.text_field :productinfo, value: Post::PAYU[:productinfo], name: "productinfo" %>
# <%= f.hidden_field :surl ,value: Post::PAYU[:surl], name: "surl" %>
# <%= f.hidden_field :furl, value: Post::PAYU[:furl], name: "furl" %>