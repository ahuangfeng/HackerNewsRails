class ContributionSerializer < ActiveModel::Serializer
  attributes :id, :title, :url, :text, :numComments, :created_at, :updated_at
end
