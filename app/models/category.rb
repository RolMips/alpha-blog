# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :article_categories, dependent: :destroy
  has_many :articles, through: :article_categories
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
end
