# frozen_string_literal: true

class FormOption
  attr_reader :id, :name

  def initialize(id:, name:)
    @id = id
    @name = name
  end
end
