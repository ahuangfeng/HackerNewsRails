require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :about, :api_key, :created_at

  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end