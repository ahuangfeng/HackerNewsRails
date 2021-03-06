require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class UserSimpleSerializer < ActiveModel::Serializer
  attributes :id, :name, :about, :created_at

  def created_at
    time_ago_in_words(object.created_at) + " ago"
  end
end