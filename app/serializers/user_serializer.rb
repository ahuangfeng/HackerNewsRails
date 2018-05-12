require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper
class UserSerializer < UserSimpleSerializer
  attributes :api_key, :email
end
